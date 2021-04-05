@echo off
color 0a
::chcp 65001
echo UPDATE DOSKEYS.BAT!
::actual doskeys
::echo "PATH TO USER DIRECTORY:" %USERPROFILE%
::ld = load doskeys
doskey ld="%USERPROFILE%\scripts\doskeys.bat"
doskey dsks="C:\Program Files\Notepad++\notepad++.exe" %USERPROFILE%\scripts\doskeys.bat
doskey colors=type C:\Users\2\Documents\colors.txt
doskey blue=color 09
doskey sky=color 03
doskey green=color 0a
doskey npp="C:\Program Files\Notepad++\notepad++.exe" $*
doskey qq=exit
doskey docs=cd %USERPROFILE%\Documents
doskey home=cd %USERPROFILE%
doskey vlc0=taskkill /f /im vlc.exe
doskey yt=C:\Python39\Scripts\youtube-dl.exe $*
doskey kr=%USERPROFILE%\scripts\keyrate\keyrate.cmd $*
:: 140 35
::doskey ffmpeg=C:\Windows\System32\ffmpeg.exe $*
::doskey fmpeg=C:\Users\2\ffmpeg.exe $*
doskey cr="C:\Program Files\Google\Chrome\Application\chrome.exe" $*
::doskey vlc1="C:\Program Files\VideoLAN\VLC\vlc.exe" $*
::doskey ffplay=C:\Windows\System32\ffplay.exe $*
::doskey putty=C:\PuTTY\putty.exe $*
::doskey sftp=C:\PuTTY\psftp.exe $*
::doskey plink=C:\PuTTY\plink.exe $*
::doskey mcssh=C:\PuTTY\putty.exe -i D:\pi23_MCS_server\1.ppk centos@95.163.215.149

::doskey jn=C:\Python27\Scripts\jupyter-notebook.exe
doskey sh=C:\cygwin64\Cygwin.bat $*
doskey sq=C:\sqlite\sqlite3.exe $*
doskey procexp="C:\Users\2\Downloads\ProcessExplorer\procexp.exe"
doskey p3=C:\Python39\python.exe -i $*
doskey p36=C:\Python36\python.exe -i $*
doskey p37=C:\Python37\python.exe -i $*
::doskey fixtab=C:\Python27\python.exe C:\Users\2\Documents\tab2spaces.py $*
::doskey jn=C:\Python36-64\Scripts\jupyter-notebook.exe $*
::doskey SqlLocalDB="C:\Program Files\Microsoft SQL Server\130\Tools\Binn\SqlLocalDB.exe" $*
::##################################################################################


::FFMPEG
::doskey rec10=ffmpeg -f gdigrab -framerate 10 -video_size 1364x768 -i desktop out.mp4
doskey rec2=ffmpeg -f gdigrab -framerate 2 -video_size 1364x768 -i desktop out.mp4
doskey rec10=ffmpeg -rtbufsize 1024M -f gdigrab -i desktop -f dshow -i audio="Микрофон (Realtek High Definition Audio)" -f dshow -i "audio=virtual-audio-capturer" -filter_complex amix -y -ac 1 -r 10 -preset veryfast -crf 22 $1.mp4
doskey rec10=ffmpeg -rtbufsize 1024M -f gdigrab -framerate 10 -video_size 1366x768 -i desktop -f dshow -i audio="Микрофон (Realtek High Definition Audio)" -f dshow -i "audio=virtual-audio-capturer" -filter_complex amix -y -ac 1 -r 10 -preset veryfast -crf 22 $1.mp4

doskey rec10_2=ffmpeg  -rtbufsize 1024M -f gdigrab -offset_x 1366 -offset_y 0 -video_size 1920x1080 -i desktop -f dshow -i audio="Микрофон (Realtek High Definition Audio)" -f dshow -i "audio=virtual-audio-capturer" -filter_complex amix -y -ac 1 -r 10 -preset veryfast -crf 22 $1.mp4
doskey rec10_2vam=ffmpeg -rtbufsize 1024M -f gdigrab -offset_x 1366 -offset_y 0 -video_size 1920x1080 -framerate 10 -i desktop -f dshow -i audio="Микрофон (Realtek High Definition Audio)" -f dshow -i "audio=virtual-audio-capturer" -filter_complex amix -y -ac 1 -r 10 -preset veryfast -crf 22 $1.mp4
doskey rec10_2va=ffmpeg -rtbufsize 1024M -f gdigrab -offset_x 1366 -offset_y 0 -video_size 1920x1080 -framerate 10 -i desktop -f dshow -i "audio=virtual-audio-capturer"  -preset veryfast -crf 22 $1.mp4
doskey rec10_2v=ffmpeg -rtbufsize 1024M -f gdigrab -offset_x 1366 -offset_y 0 -video_size 1920x1080 -framerate 10 -i desktop $1.mp4

::doskey shcam=ffmpeg -f dshow -framerate 15 -video_size 320x240 -i video="Integrated Camera" -pix_fmt yuv420p -f mpegts - | ffplay -analyzeduration 10 -f mpegts -
::doskey shcam=C:\Users\2\Documents\Task-Stack-Widget\task-data\1363\solution.cmd
::##################################################################################

::doskey SQLCMD110="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.exe" $*
::doskey bcp110="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\bcp.exe" $*
::doskey dumpbin64="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\dumpbin.exe" $*
::doskey dumpbin32="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx86\x86\dumpbin.exe" $*
::doskey chrome="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" $*
doskey sqlite="C:\Users\%USERPROFILE%\Documents\sqlite\sqlite3.exe" $*
::doskey wsldir=cd "C:\Users\2\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs"
::doskey copy_wsldir =echo "C:\Users\2\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs" | clip
::doskey junction="C:\Users\2\Documents\Scripts\Junction\junction.exe"
doskey exp=explorer %CD% $*
:: Notice "%%h" instead of "%h" AND "%%x0D" in the end - a fix for batch script.
:: QUICK CD NAVIGATE SHORTCUTS.
::doskey f1=cd C:\Users\2\Documents\Task-Stack-Widget\ 
::doskey f2=cd C:\Users\2\Documents\Task-Stack-Widget\task-data\
::doskey f3=cd C:\
::doskey f4=cd C:\Windows\Microsoft.NET
::doskey f5=cd C:\Users\2\Documents\Task-Stack-Widget\task-data\1206
doskey reboot=shutdown /f /r /t 1
doskey sleep=rundll32.exe powrprof.dll,SetSuspendState 0,1,0

::git
doskey giche=git checkout $*
doskey gcm=git commit -m $*
doskey undo="C:\Users\2\Documents\git-tutorial\git-undo.bat"
doskey ga=git add -A
doskey git-bash="C:\Program Files\Git\git-bash.exe"
doskey gpu=git push origin main
doskey gpuster=git push origin master
doskey gpull=git pull origin main
doskey gpullster=git pull origin master
::doskey gitlog=git log --date=format:"%%Y-%%m-%%d %%H:%%M" --pretty=format:"%%h%%x09%%ai%%x09%%Cblue%%s%%x0D"
doskey gitlog=git log --pretty=format:"%%h%%x09%%ai%%x09%%Cblue%%s%%x0D"
doskey githelp="C:\Program Files\Git\mingw64\share\doc\git-doc\git.html"

::doskey g=echo TURBO GIT MACRO ^&^& git add -A ^&^& git commit -m "$1" ^&^& git push origin master
::usage:  >g COMMENT
doskey g=git add -A $T$T git commit -m "$1" $T$T git push origin master

::doskey d1=echo DOSKEY A1 $T$T echo DOSKEY A2
:: this is better:
::doskey d2=echo DOSKEY B1 ^&^& echo DOSKEY B2
:: with argument:
::doskey d3=echo DOSKEY B1 $1 ^&^& echo DOSKEY B2

doskey rovlc= "C:\Users\2\Documents\Task-Stack-Widget\task-data\1268\drops_moc_fild11_3_snap_nolightmap_20fps.mp4"
doskey tsw=cd %USERPROFILE%\Documents\Task-Stack-Widget $T$T %USERPROFILE%\Documents\Task-Stack-Widget\run.bat


:: [CSHARP][C#]
doskey ildasm="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\ildasm.exe" $*
doskey csc="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe" $*
doskey csc324="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe" $*
doskey csc644="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe" $*
doskey ilasm644="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ilasm.exe" $*
doskey ilasm324="C:\Windows\Microsoft.NET\Framework\v4.0.30319\ilasm.exe" $*
doskey mdbg="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\MDbg.0.1.0\tools\Mdbg.exe" $*

doskey wherecontexmenu=type C:\Users\2\Documents\Task-Stack-Widget\task-data\1282\wherecontexmenu.txt

::django
doskey dja="C:\Python36-64\Scripts\django-admin.exe" $*

doskey task=cd %USERPROFILE%\Documents\Task-Stack-Widget\task-data\$1

::c++
doskey msvcdir=cd C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
doskey cl="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\cl.exe" $*
doskey vcvars32="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat"
doskey vcvars64="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
doskey vcvarsall="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat"

doskey expcd=explorer %%cd%%

::gcloud
::doskey gcl="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" $*
::doskey gstop="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" compute instances stop instance-5
::doskey gstop2="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" compute instances stop instance-6
::doskey gstart="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" compute instances start instance-5
::doskey gstart2="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" compute instances start instance-6
::doskey gcloud="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" $*
::doskey centos="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk.staging.staging\bin\gcloud.cmd" beta compute --project "mystic-song-226805" ssh --zone "us-central1-a" "instance-6"
::doskey winserver="C:\Windows\System32\mstsc.exe" C:\Users\2\Documents\Task-Stack-Widget\task-data\1032\instance-5.rdp
::doskey ws="C:\Windows\System32\mstsc.exe" C:\Users\2\Documents\Task-Stack-Widget\task-data\1032\instance-5.rdp

::doskey qtdemo=C:\Python36-64\python.exe C:\Python36-64\Lib\site-packages\PyQt4\examples\demos\qtdemo\qtdemo.pyw

:: LINUX TOOLS
doskey grep=C:\cygwin64\bin\grep.exe $*

::PYTHON TOOLS
::doskey p2help="C:\Python36-64\Doc\python365.chm"
doskey p3help=C:\Python39\Doc\python392.chm
