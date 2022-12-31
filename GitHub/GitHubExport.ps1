# Author: Martin Wetzko
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
param(
    [Parameter(Mandatory, Position = 0)]
    [string] $user,
    [Parameter(Mandatory, Position = 1)]
    [string] $repo,
    [Parameter(Position = 2)]
    [string] $path = "",
    [Parameter(Position = 3)]
    [string] $outdir = "."
)

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {
    $data = (Invoke-WebRequest "https://api.github.com/repos/$($user)/$($repo)/git/trees/master?recursive=1").Content | ConvertFrom-Json -Depth 999

    if (!($data.sha)) {
        throw "Given user and repo combination is not valid!"    
    }

    if (!($data.tree) -or ($data.tree.length -eq 0)) {
        throw "Repo is empty"    
    }

    $path = $path.Trim("/")

    if ($path -eq "") {
        $filter = $data.tree
    }
    else {
        $match = "^$($path)/"
        $filter = $data.tree | Where-Object { ($_.path -eq $path) -or ($_.path -match $match) }
    }

    $null = $path -match "^((?:[^/]*/)*)"

    $remove = ($Matches.1).Length

    $outdir = (Get-Item -Path $outdir).FullName

    $filter | ForEach-Object {
        if ($_.type -ne "tree") {
        
            $part = $_.path.Substring($remove)
        
            $filename = Join-Path $outdir $part

            $filename

            $dir = Split-Path -Path $filename
        
            if (!(Test-Path $dir)) {
                $null = New-Item $dir -ItemType "directory"
            }

            Invoke-WebRequest "https://github.com/$($user)/$($repo)/raw/master/$($_.path)" -OutFile $filename
        }
    }
}
finally {
    Pop-Location
}