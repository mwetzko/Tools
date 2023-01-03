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

Write-Host "Installing Chromium..." -ForegroundColor DarkGray

$chromium = ExecSSH "apt-cache pkgnames chromium | egrep ""^chromium(-browser)?$"" || echo """""

if ($chromium -is [array]) {
    if ($chromium.Length -gt 0) {
        $chromium = $chromium[0]
    }
    else {
        $chromium = $null
    }
}

if ($chromium -notmatch "^chromium") {
    throw "Chromium[-browser] package not available for install but is required."
}

$null = ExecSSH "sudo apt-get install $($chromium) --yes"
return $chromium