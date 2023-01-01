# Author: Martin Wetzko
# Thanks to https://reelyactive.github.io/diy/pi-kiosk/ for making this script possible
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
param(
    [Parameter(Mandatory, Position = 0, HelpMessage = "Hostname")]
    [string] $hostname,
    [Parameter(Mandatory, Position = 1, HelpMessage = "Username")]
    [string] $username,
    [Parameter(Mandatory, Position = 2, HelpMessage = "Password")]
    [string] $password,
    [Parameter(Mandatory, Position = 3, HelpMessage = "Url")]
    [string] $url,
    [switch] $reboot
)

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {

    . ".\EnsurePlink.ps1"
    . ".\EnsurePscp.ps1"

    TestSSH

    $os = ExecSSH "uname -srv"

    Write-Host "Remote machine is: " -NoNewline -ForegroundColor DarkGray
    Write-Host $os -ForegroundColor Green
    
    Write-Host "Update $($os) to latest version..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get update"

    Write-Host "Installing Chromium..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get install chromium --yes"

    Write-Host "Installing Window Manager..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get install matchbox-window-manager xautomation unclutter --yes"

    Write-Host "Ensure kiosk script..." -ForegroundColor DarkGray

    $null = ExecSCP ".\Template.WebKiosk.txt" "/home/$($username)/kiosk"
    $null = ExecSSH "sudo sed -i 's;chrome://version;$($url);g' ~/kiosk"
    $null = ExecSSH "sudo chmod 755 ~/kiosk"

    . ".\AutoBash.ps1"

    ExecKioskBash "xinit ./kiosk -- vt\`$(fgconsole)"

    . ".\AutoLogin.ps1"
    . ".\AutoReboot.ps1"
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}