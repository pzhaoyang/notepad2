@echo off
:: BatchGotAdmin (Run as Admin code starts)
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
::=========================Got Administrator perm=======================

@echo off
echo.
echo Change Notepad.exe's owner:
takeown /a /f %windir%\notepad.exe
takeown /a /f %windir%\system32\notepad.exe
echo==========================================
echo.
echo Change Notepad.exe's perm to administrators:
cacls %windir%\notepad.exe /E /C /G administrators:F
cacls %windir%\system32\notepad.exe /E /C /G administrators:F
echo==========================================
echo.
if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="X86" (
set notepad=notepad_x86.exe
) ELSE echo (
set notepad=notepad_x64.exe
)
echo Copy %notepad% to %windir%\
copy %notepad% %windir%\notepad.exe /Y
copy %notepad% %windir%\system32\notepad.exe /Y
pause
