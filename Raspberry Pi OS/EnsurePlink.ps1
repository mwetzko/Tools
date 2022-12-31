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

$plink = Get-Command "PLINK.EXE" -ErrorAction Ignore

if (!$plink) {
    throw "PLINK.EXE (From Putty) is required to run all SSH operations. Please install Putty package!"
}

Write-Host "Using '$($plink.Path)' for SSH tasks"

function ExecSSH {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $commands
    )
    & $plink -batch -pw "$($password)" "$($username)@$($hostname)" "$($commands)"

    if (!$?) {        
        throw "Last command failed"
    }
}