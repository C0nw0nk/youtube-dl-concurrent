@ECHO OFF & setLocal EnableDelayedExpansion

:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/youtube-dl-concurrent
:: https://www.facebook.com/C0nw0nk

color 0A
%*
TITLE %window_titles%
echo %URL%
start /B /min /wait "%root_path%" youtubedl.cmd >nul 2>&1

EXIT