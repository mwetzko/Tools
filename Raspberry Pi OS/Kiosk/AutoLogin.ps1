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

Write-Host "Make remote device boot into console..." -ForegroundColor DarkGray

$null = ExecSCP ".\Template.AutoLogin.txt" "/home/$($username)/auto.txt"
$null = ExecSSH "sudo sed -i 's;`$USER;$($username);g' ~/auto.txt"
$null = ExecSSH "sudo mv -f ~/auto.txt /etc/systemd/system/getty@tty1.service.d/autologin.conf"
$null = ExecSSH "sudo systemctl --quiet set-default multi-user.target"