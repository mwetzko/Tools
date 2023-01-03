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

Write-Host "Installing Dotnet..." -ForegroundColor DarkGray

$exists = ExecSSH "test -f ~/.dotnet/dotnet && echo ""yes"" || echo ""no"""

if ($exists -ne "yes") {
    $null = ExecSSH "wget https://dot.net/v1/dotnet-install.sh -O ~/dotnet-install.sh"
    $null = ExecSSH "sudo chmod +x ~/dotnet-install.sh"
    $null = ExecSSH "~/dotnet-install.sh --version latest"
}