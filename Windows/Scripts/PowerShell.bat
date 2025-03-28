REM # Author: Martin Wetzko
REM # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM # AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
REM # SOFTWARE.

@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET KEY_NAME="HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\PowerShell.exe"

FOR /F "usebackq tokens=2*" %%A IN (`^(REG QUERY %KEY_NAME% /ve ^| find "REG_EXPAND_SZ"^) 2^>nul`) DO (
	CALL SET PwshPath="%%B"
)

SET PS_CMD="EXIT 777"

IF DEFINED PwshPath (

	@ECHO Using !PwshPath!
	
	!PwshPath! -NoLogo -NoProfile -Command !PS_CMD!
	
	IF !ERRORLEVEL! == 777 (
		!PwshPath! -NoLogo -NoProfile -ExecutionPolicy Bypass %*
		EXIT /B !ERRORLEVEL!
	)
)

@ECHO Using "powershell"

powershell -NoLogo -NoProfile -Command !PS_CMD!

IF !ERRORLEVEL! == 777 (
	powershell -NoLogo -NoProfile -ExecutionPolicy Bypass %*
	EXIT /B !ERRORLEVEL!
)

EXIT /B 999