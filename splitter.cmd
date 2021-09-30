@ECHO OFF & setLocal EnableDelayedExpansion

:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/youtube-dl-concurrent
:: https://www.facebook.com/C0nw0nk

color 0A
%*
TITLE %window_titles%

echo Building download lists please wait...

SET "sourcedir=%root_path%lists"
SET /a fcount=0
rem Limit of lines per text file
SET /a llimit=%number_of_processes%
SET /a lcount=%llimit%
FOR /f "usebackqdelims=" %%a IN ("%sourcedir%\list.txt") DO (
 CALL :select
 FOR /f "tokens=1*delims==" %%b IN ('set dfile') DO IF /i "%%b"=="dfile" >>"%%c" ECHO(%%a
)
GOTO :EOF
:select
SET /a lcount+=1
IF %lcount% lss %llimit% GOTO :EOF
SET /a lcount=0
SET /a fcount+=1
SET "dfile=%sourcedir%\splits\file%fcount:~-2%.txt"
GOTO :EOF

EXIT