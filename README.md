# Windows YouTube downloader concurrent youtube-dl
Youtube-dl youtube downloader Windows to run multiple concurrent parallel video downloads simultaneously

#### This is for Windows OS

# Usage

Inside the ```lists folder``` | ```\lists\lists.txt``` you will find ```lists.txt``` input your URL's to this file every line should have one URL only.

Make sure you have ```youtube-dl.exe``` and ```ffmpeg.exe``` inside the main directory with the ```RUN_ME.cmd``` file

Execute the ```RUN_ME.cmd``` file

Enjoy concurrent downloads downloading multiple urls from multiple websites using as much bandwidth as you wish.

# Settings

If you want to convert videos with `FFMPEG.exe` after they have downloaded you can answer `Y` for `YES` or `N` for `NO`

To edit FFMPEG.exe command line conversion options look inside ```youtubedl.cmd```

You can choose to either download all the URL's you input to the ```\lists\lists.txt``` file all at once or you can have a throttled download experience where you only download 20 or so at a time.

In my opinion the trottled is safer because if you have allot of URL links lets say `3000+` to download it will download them in a sensible manner. If you took the unthrottled approach it will open over `3000+` command prompt windows slowing your computer to a grinding holt.

#Info

It will open a few command prompt windows one per each URL and start the download process for that URL once the download has completed it will be put into the `\Downloads\` folder then if you have selected it will convert the video with FFMPEG into a size / format that you want.

# Requirements

FFMPEG binary from https://ffmpeg.org/download.html#build-windows
Youtube-DL binary from https://youtube-dl.org/
