# Author: Martin Wetzko
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$pscp = Get-Command "PSCP.EXE" -ErrorAction Ignore

if (!$pscp) {
    throw "PSCP.EXE (From Putty) is required to run all SSH operations. Please install Putty package!"
}

Write-Host "Using '$($pscp.Path)' for SSH copy file tasks"    

function ExecSCP {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $source,
        [Parameter(Mandatory, Position = 1)]
        [string] $destination
    )
    & $pscp -batch -pw "$($password)" $source "$($username)@$($hostname):$($destination)"

    if (!$?) {        
        throw "Last command failed"
    }
}