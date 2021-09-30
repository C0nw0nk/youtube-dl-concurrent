@ECHO OFF & setLocal EnableDelayedExpansion

:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/youtube-dl-concurrent
:: https://www.facebook.com/C0nw0nk

color 0A
%*
TITLE %window_titles%


echo %%i
for /F "tokens=*" %%A in (%root_path%lists\splits\%give%) do (

SET URL=%%A

echo Starting download and conversion this window will close when all have finished

rem start /wait "%root_path%" youtubedl.cmd SET URL=%%A
start /B /min /wait "%root_path%" download.cmd SET URL=%%A >nul 2>&1

)

echo All downloads finished.
EXIT