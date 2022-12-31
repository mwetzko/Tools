# Author: Martin Wetzko
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
function Find-EnvObject {
    param (
        [Parameter(Position = 0)]
        $key,
        [Parameter(Position = 1)]
        $vars
    )
    
    for ($i = 0; $i -lt $vars.Count; $i++) {
        if ($vars[$i].Key -eq $key) {       
            return $vars[$i]
        }
    }

    return $null
}

$script:capturedvars = Get-ChildItem env:*

function Restore-EnvVars {    

    Get-ChildItem env:* | ForEach-Object {

        $obj = Find-EnvObject $_.Key $script:capturedvars

        if ($obj) {
            [System.Environment]::SetEnvironmentVariable($_.Key, $obj.Value)
        }
        else {
            [System.Environment]::SetEnvironmentVariable($_.Key, $null)
        }
    }
}