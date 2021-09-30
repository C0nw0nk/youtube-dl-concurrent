@ECHO OFF & setLocal EnableDelayedExpansion

:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/youtube-dl-concurrent
:: https://www.facebook.com/C0nw0nk

color 0A
%*
TITLE %window_titles%
SET root_path=%~dp0

forfiles /P %root_path%Converted\ /M *.* /S /C "CMD /C if @fsize lss 1000000 echo @PATH @FSIZE"
forfiles /P %root_path%Converted\ /M *.* /S /C "CMD /C if @fsize lss 1000000 del @PATH"

rem pause
exit