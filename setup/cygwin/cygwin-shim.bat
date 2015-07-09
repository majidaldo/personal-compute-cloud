@echo off

set COMMAND=%1

REM If you used the standard Cygwin installer this will be C:\cygwin
call win_env.bat
rem set CYGWIN=%USERPROFILE%\.babun\cygwin
set CYGWIN=%babundir%\cygwin

REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe
set SH=%CYGWIN%\bin\zsh.exe

if not exist "%SH%" (
    echo cygwin's sh.exe not found. Did you delete %CYGWIN% ?
    exit /b 255
)

"%SH%" -c "[[ -x "%COMMAND%" ]]"
if not errorlevel 0 (
    echo %COMMAND% not found. Did you uninstall it ?
    exit /b 255
)

"%SH%" -c "%*"
