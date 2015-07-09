REM run as admin
REM to make ansible stuff visible
rem set PATH=%PATH%;%CD%
REM symlink does not work. have to make a hard lnk /H

REM put this in conemu task
REM * cd "path\to\this\dir" & "path\to\this\init.bat" & timeout 11
REM (blank line)
REM >  "C:\Users\Majid\Documents\GitHub\tsad-proj\tsad-bigfiles\windows\babun\cygwin\bin\mintty.exe"

call win_env.bat


del %babunhome%\.babunrc
rem mklink /H  %USERPROFILE%\.babunrc .bashrc
copy .bashrc %babunhome%\.babunrc
