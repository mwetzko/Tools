# Author: Martin Wetzko
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
param(
    [Parameter(Position = 0)]
    [string] $filter = ""
)

function Out-Blue {
    process { Write-Host $_ -ForegroundColor Blue }
}

function Out-Yellow {
    process { Write-Host $_ -ForegroundColor Yellow }
}

function Out-Green {
    process { Write-Host $_ -ForegroundColor Green }
}

function Out-Red {
    process { Write-Host $_ -ForegroundColor Red }
}

function Set-DictItem {
    param (
        [Parameter(Mandatory, Position = 0)]
        $dict,
        [Parameter(Mandatory, Position = 1)]
        $key,
        [Parameter(Mandatory, Position = 2)]
        $value
    )

    if ($dict.ContainsKey($key)) {
        $dict[$key] = $value
    }
    else {
        $dict.Add($key, $value)
    }
}

function Out-Process-Choice ([string] $proc, [string] $other, [string] $indent) {
    process {
        Write-Host $indent -ForegroundColor Gray -NoNewline
        Write-Host $proc -ForegroundColor Blue -NoNewline
        Write-Host $other -ForegroundColor Gray
    }
}

function Get-ProcDict {
    param(
        [Parameter( Position = 0)]
        [string]$filter = ""
    )

    $filtered = New-Object System.Collections.ArrayList

    (Get-CimInstance Win32_Process) | Where-Object { $_.ExecutablePath } | ForEach-Object {
        $proc = Get-Process -Id $_.ProcessId
        if ($proc) {
            $null = $filtered.Add(
                @{ 
                    ProcessId       = $_.ProcessId
                    ParentProcessId = $_.ParentProcessId
                    ProcessName     = $proc.Name
                    ModuleName      = $proc.MainModule.ModuleName; 
                    FileDescription = $proc.MainModule.FileVersionInfo.FileDescription; 
                })
        }
    }

    $dict = @{}

    $filtered | ForEach-Object {
        if ([string]::IsNullOrEmpty($filter) -or (($_.ModuleName -imatch $filter) -or ($_.FileDescription -imatch $filter))) {
            Set-DictItem $dict $_.ProcessId @{ Process = $_; Children = @{} }
        }
    }

    $dict
}

function Get-ProcessTree {
    param(
        [Parameter(Mandatory, Position = 0)]
        $dict
    )

    $tree = @{}

    $($dict.Keys) | ForEach-Object {
        $item = $dict[$_]
        $proc = $item.Process

        if ($dict.ContainsKey($proc.ParentProcessId)) {
            Set-DictItem $dict[$proc.ParentProcessId].Children $proc.ProcessId $item
        }
        else {
            Set-DictItem $tree -key $proc.ProcessId -value $item
        }
    }

    $tree
}

function Show-ProcessTree {
    param (
        [Parameter(Mandatory, Position = 0)]
        $tree,
        [Parameter( Position = 1)]
        [int]$Indent = 0,
        [Parameter( Position = 2)]
        [string]$Prefix = ""
    )

    $count = 0
    $total = $tree.Count

    $($tree.Keys) | ForEach-Object {

        $item = $tree[$_]

        $count++
        $isLast = ($count -eq $total)

        $pre = "        "

        $currentPrefix = if ($Indent -eq 0) { "" } 
        else { "$Prefix" + $(if ($isLast) { "$($pre)└ " } else { "$($pre)├ " }) }

        $proc = $item.Process

        Out-Process-Choice -proc "[$($proc.ProcessId.ToString().PadLeft(5, " "))] $($proc.ProcessName)" -other " ($($proc.ModuleName))" -indent $currentPrefix

        $nextPrefix = if ($Indent -eq 0) { "" } 
        else { "$Prefix" + $(if ($isLast) { "$($pre)  " } else { "$($pre)│ " }) }

        $children = $item.Children

        if ($children.Count -gt 0) {
            Show-ProcessTree $children ($Indent + 1) $nextPrefix
        }
    }
}

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {
    if (!(Test-Path "..\procdump\procdump.exe") -or !(Test-Path "..\procdump\procdump64.exe")) {
        $tmppath = "..\tmp"
        if (!(Test-Path $tmppath)) {
            $null = New-Item $tmppath -ItemType Directory
        }
        try {
            $tmp = "..\tmp\Procdump.zip"
            if (!(Test-Path $tmp)) {
                try {
                    "Downloading https://download.sysinternals.com/files/Procdump.zip..." | Out-Blue
                    Invoke-WebRequest "https://download.sysinternals.com/files/Procdump.zip" -OutFile $tmp
                }
                catch {
                    if (Test-Path $tmp) {
                        Remove-Item $tmp -Force
                    }
                }
            }

            if (!(Test-Path $tmp)) {
                "Failed to download Procdump.zip" | Out-Red
                return
            }

            $extract = "..\procdump"

            try {
                Expand-Archive $tmp $extract
            
                if (Test-Path $tmp) {
                    Remove-Item $tmp -Force
                }
            }
            catch {
                if (Test-Path $extract) {
                    Remove-Item $extract -Recurse -Force
                }
            }

            if (!(Test-Path "..\procdump\procdump.exe")) {
                "Failed to extract procdump.exe" | Out-Red
                return
            }

            if (!(Test-Path "..\procdump\procdump64.exe")) {
                "Failed to extract procdump64.exe" | Out-Red
                return
            }
        }
        finally {
            if (Test-Path $tmppath) {
                Remove-Item $tmppath -Recurse -Force
            }
        }
    }

    $processes = Get-ProcDict $filter

    if ($processes.Count -gt 1) {

        $tree = Get-ProcessTree -dict $processes

        while (1) {
            "Choose process:" | Out-Host
            Show-ProcessTree $tree
            $choice = Read-Host "Enter Number"
            if ($choice -match '[0-9]+') {
                $key = [UInt32]::Parse($Matches[0])
                if ($processes.ContainsKey($key)) {
                    $chosenProcess = $processes[$key].Process
                    break
                }
            }
        } 
    }
    elseif ($processes.Count -gt 0) {
        $chosenProcess = $processes[ $($processes.Keys)[0]].Process
    }

    if (!$chosenProcess) {
        "No process to choose from!" | Out-Yellow
        return
    }

    "Collecting crash dump for process [$($chosenProcess.ProcessId)] $($chosenProcess.ProcessName) ($($chosenProcess.ModuleName)) into`r`n" | Out-Green

    $dumpfolder = Join-Path $(Get-Location) "..\dumps"

    if (!(Test-Path($dumpfolder))) {
        $null = New-Item $dumpfolder -ItemType Directory
    }

    $dumpfolder = (Get-Item -Path $dumpfolder).FullName

    $dumpfolder | Out-Host

    if ([System.Environment]::Is64BitOperatingSystem) {
        & "..\procdump\procdump64.exe" -accepteula -ma -e -o -t $($chosenProcess.ProcessId) $dumpfolder
    }
    else {
        & "..\procdump\procdump.exe" -accepteula -ma -e -o -t $($chosenProcess.ProcessId) $dumpfolder
    }
}
finally {
    Pop-Location
}