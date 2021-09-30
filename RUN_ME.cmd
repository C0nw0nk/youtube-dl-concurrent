@ECHO OFF & setLocal EnableDelayedExpansion

:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/youtube-dl-concurrent
:: https://www.facebook.com/C0nw0nk

color 0A
%*

SET window_titles=C0nw0nk - Youtube-DL - concurrent Downloader
SET root_path=%~dp0

TITLE %window_titles%

if not exist "%root_path%Converted" mkdir "%root_path%Converted"
if not exist "%root_path%Downloads" mkdir "%root_path%Downloads"
if not exist "%root_path%lists" mkdir "%root_path%lists"
if not exist "%root_path%lists\splits" mkdir "%root_path%lists\splits"
if not exist "%root_path%lists\list.txt" (goto :warning_liststext) else (goto :skip_warning_liststext)
:warning_liststext
echo Edit %root_path%lists\list.txt and add a list of URL's to download....
@echo>"%root_path%lists\list.txt
:skip_warning_liststext

echo Do you want to convert videos with FFMPEG after they have downloaded
echo [Y] YES [N] NO :
set /p question=
echo How many Youtube-DL.exe processes do you want running and downloading/converting at the same time :
set /p question2=
echo Do you want to Use FTP Features of the script ?
echo [Y] YES [N] NO :
set /p question5=

set ftp_file=%root_path%ftp.txt
IF EXIST "%ftp_file%" (goto :ftp_settings_exist) else (goto :ftp_settings_not_exist)
:ftp_settings_not_exist

echo FTP Settings setup...
echo Please enter the FTP server address
echo [IP Address or Domain name] :
set /p question_ftp_server=
echo Please enter the FTP server username
echo [root] :
set /p question_ftp_user=
echo Please enter the FTP server password
echo [password] :
set /p question_ftp_password=
echo Please enter the FTP server directory
echo [/home/uploads/] :
set /p question_ftp_directory=

echo >%ftp_file%
echo %question_ftp_server%>>%ftp_file%
echo %question_ftp_user%>>%ftp_file%
echo %question_ftp_password%>>%ftp_file%
echo %question_ftp_directory%>>%ftp_file%

:ftp_settings_exist
echo Your current FTP settings are :

set get_ftp_server=1
set /a get_line -=1
for /F "skip=%get_ftp_server% delims=" %%A in (%ftp_file%) do (
 set ftp_server=%%A
 echo !ftp_server!
 goto :end_ftploop
)
:end_ftploop
set get_ftp_user=2
set /a get_line -=1
for /F "skip=%get_ftp_user% delims=" %%A in (%ftp_file%) do (
 set ftp_user=%%A
 echo !ftp_user!
 goto :end_ftploop
)
:end_ftploop
set get_ftp_password=3
set /a get_line -=1
for /F "skip=%get_ftp_password% delims=" %%A in (%ftp_file%) do (
 set ftp_password=%%A
 echo !ftp_password!
 goto :end_ftploop
)
:end_ftploop
set get_ftp_directory=4
set /a get_line -=1
for /F "skip=%get_ftp_directory% delims=" %%A in (%ftp_file%) do (
 set ftp_directory=%%A
 echo !ftp_directory!
 goto :end_ftploop
)
:end_ftploop

echo Do you want to use these FTP settings or create new FTP settings
echo [Y] YES use current [N] NO create new :
set /p question8=

IF EXIST "%ProgramFiles%\WinSCP\winscp.com" (goto :ftp_exist)
IF EXIST "%ProgramFiles(x86)%\WinSCP\winscp.com" (goto :ftp_exist)
IF EXIST "%LocalAppData%\Programs\WinSCP\winscp.com" (goto :ftp_exist)
goto :ftp_not_exist
:ftp_exist
echo Do you want to upload videos to FTP once converted
echo [Y] YES [N] NO :
set /p question3=
if /I %question3%==y goto :ftp_question2
if /I %question3%==Y goto :ftp_question2
if /I %question3%==yes goto :ftp_question2
if /I %question3%==YES goto :ftp_question2
:ftp_question2
if /I %question3%==n goto :ftp_question3
if /I %question3%==N goto :ftp_question3
if /I %question3%==no goto :ftp_question3
if /I %question3%==NO goto :ftp_question3
echo Folder name inside %ftp_directory% that you want to upload these files to :
set /p question4=
:ftp_question3
:ftp_not_exist

IF EXIST "%ProgramFiles%\WinSCP\winscp.com" (goto :skip_warn_winscp)
IF EXIST "%ProgramFiles(x86)%\WinSCP\winscp.com" (goto :skip_warn_winscp)
IF EXIST "%LocalAppData%\Programs\WinSCP\winscp.com" (goto :skip_warn_winscp)
echo To upload files with FTP you need WinSCP installed on your machine https://winscp.net/
:skip_warn_winscp

echo Do you want to Delete ORIGINALLY Downloaded files once they have been converted with FFMPEG to save disk space ?
echo [Y] YES [N] NO :
set /p question6=

echo Do you want to Delete files converted by FFMPEG once they have been uploaded to your specified FTP server to save disk space ?
echo [Y] YES [N] NO :
set /p question7=

rem wait 1 second
rem PING -n 1 127.0.0.1>nul

rem fix list urls to reduce the amount
set text_name=lists\list.txt
set text_name_output=lists\output_list.txt
set /a counter=0
for /f %%a in (%root_path%%text_name%) do set /a counter+=1

echo Inside your lists file %root_path%lists\list.txt you currently have %counter% URL's to download and convert do you want to reduce the amount of files you will download and upload ?
echo [Y] YES [N] NO :
set /p question9=

if /I %question9%==y goto :reduce_text_file
if /I %question9%==Y goto :reduce_text_file
if /I %question9%==yes goto :reduce_text_file
if /I %question9%==YES goto :reduce_text_file
if /I %question9%==n goto :skip_reduce_text_file
if /I %question9%==N goto :skip_reduce_text_file
if /I %question9%==no goto :skip_reduce_text_file
if /I %question9%==NO goto :skip_reduce_text_file
:reduce_text_file

echo Please set the MAX limit to the total number of URL's you wish to download
echo [EXAMPLE : 1600] :
set /p question10=

set /a max_line_count=%question10%
if !counter! LSS %max_line_count% (
rem echo %text_name% is less than max limit
)else (
rem echo %text_name% is more than max limit
set /a "counter_new=%counter%-%max_line_count%"
more +!counter_new! "%root_path%%text_name%" >"%root_path%%text_name_output%"
move /y "%root_path%%text_name_output%" "%root_path%%text_name%" >nul
)

:skip_reduce_text_file

rem amount of lines provided divided by number of download processes = line count per file
rem set process_limit=10
set process_limit=%question2%
set /a number_of_processes=%counter%    /    %process_limit%
rem echo %number_of_processes%

del "%root_path%lists\splits\*.txt"
call "%root_path%splitter.cmd"

FOR /F %%i IN ('dir /b %root_path%lists\splits\') DO (
SET give=%%i
rem echo %give%
rem wscript.exe "%root_path%invisible.vbs" "%root_path%text_pass.cmd"
start /min "%root_path%" text_pass.cmd >nul 2>&1
)

echo All downloads finished.
echo Running Cleanup
call "%root_path%cleanup.cmd"
EXIT