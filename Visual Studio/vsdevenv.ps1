# Author: Martin Wetzko
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
function Invoke-VSDevEnvironment {
    $installationPath = & ".\vswhere.exe" -latest -property installationPath
    $Command = Join-Path $installationPath "Common7\Tools\vsdevcmd.bat"

    if (!(Test-Path $Command)) {
        throw "vsdevcmd.bat not found!"
    }

    & "${env:COMSPEC}" /s /c "`"$Command`" -no_logo && set" | Foreach-Object {
        if ($_ -match '^([^=]+)=(.*)') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }
}

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {
    if (!(Test-Path ".\vswhere.exe")) {
        $data = Invoke-WebRequest "https://api.github.com/repos/microsoft/vswhere/releases/latest" | ConvertFrom-Json
        Invoke-WebRequest "https://github.com/microsoft/vswhere/releases/download/$($data.tag_name)/vswhere.exe" -OutFile "vswhere.exe"
    }

    if (!$env:DevEnvDir) {
        Write-Host "Loading Build Environment..."
        Invoke-VSDevEnvironment
    }
}
finally {
    Pop-Location
}