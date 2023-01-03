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

Write-Host "Prepare kiosk script for auto start..." -ForegroundColor DarkGray

$bashrc = ExecSSH "cat ~/.bashrc"

$cmd = "./kioskexec #KIOSK ENTRY"

if ($bashrc -notcontains $cmd) {
    $null = ExecSSH "echo """" >> ~/.bashrc"
    # use \ to escape variable sequence
    $null = ExecSSH "echo ""$($cmd)"" >> ~/.bashrc"
}

function ExecKioskBash {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $commands
    )
    $null = ExecSCP ".\Template.AutoBash.txt" "/home/$($username)/kioskexec"
    $null = ExecSSH "echo """" >> ~/kioskexec"
    $null = ExecSSH "echo ""$($commands)"" >> ~/kioskexec"
    $null = ExecSSH "sudo chmod 755 ~/kioskexec"
}