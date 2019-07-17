@echo off


::actual doskeys

::ld = load doskeys
doskey ld=C:\users\2\doskeys.bat
doskey p2=C:\Python27\python.exe -i $*
doskey p264=C:\Python27-64\python.exe -i $*
doskey p73=C:\Python37-32\python.exe -i $*
doskey p37=C:\Python37-64\python.exe -i $*
doskey npp="C:\Program Files (x86)\Notepad++\notepad++.exe" $*
doskey qq=exit
doskey dsks="C:\Program Files (x86)\Notepad++\notepad++.exe" C:\users\2\doskeys.bat
doskey docs=cd C:\users\user\Documents
doskey home=cd C:\users\user
doskey pip2=C:\Python27\Scripts\pip.exe $*
doskey vlc0=taskkill /f /im vlc.exe
doskey yt=C:\Python27\Scripts\youtube-dl.exe $*
doskey kr=D:\pi17\keyrate.cmd $*
:: 140 35
doskey ffmpeg=C:\Windows\System32\ffmpeg.exe $*
doskey cr="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" $*
doskey vlc1="C:\Program Files\VideoLAN\VLC\vlc.exe" $*
doskey ffplay=C:\Windows\System32\ffplay.exe $*
doskey v=taskkill /f /im vlc.exe
doskey putty=C:\PuTTY\putty.exe $*
doskey sftp=C:\PuTTY\psftp.exe $*
doskey plink=C:\PuTTY\plink.exe $*
doskey mcssh=C:\PuTTY\putty.exe -i D:\pi23_MCS_server\1.ppk centos@95.163.215.149

doskey jn=C:\Python27\Scripts\jupyter-notebook.exe
doskey sh=C:\cygwin64\Cygwin.bat $*
doskey yd=C:\Python27\Scripts\youtube-dl.exe $*
doskey sq=C:\sqlite\sqlite3.exe $*
doskey procexp="C:\Users\2\Downloads\ProcessExplorer\procexp.exe"
doskey p3=C:\Python36-64\python.exe -i $*
doskey fixtab=C:\Python27\python.exe C:\Users\2\Documents\tab2spaces.py $*
doskey jn=C:\Python36-64\Scripts\jupyter-notebook.exe $*
doskey SqlLocalDB="C:\Program Files\Microsoft SQL Server\130\Tools\Binn\SqlLocalDB.exe" $*
doskey rec10=ffmpeg -f gdigrab -framerate 10 -i desktop out.mp4
 
doskey SQLCMD110="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.exe" $*
doskey bcp110="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\bcp.exe" $*
doskey dumpbin64="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\dumpbin.exe" $*
doskey dumpbin32="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx86\x86\dumpbin.exe" $*
doskey chrome="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" $*
doskey sqlite="C:\Users\2\Documents\sqlite\sqlite3.exe" $*
doskey wsldir=cd "C:\Users\2\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs"
doskey copy_wsldir =echo "C:\Users\2\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs" | clip
doskey junction="C:\Users\2\Documents\Scripts\Junction\junction.exe"
doskey git-bash="C:\Program Files\Git\git-bash.exe"
doskey undo="C:\Users\2\Documents\git-tutorial\git-undo.bat"
doskey ga=git add -A
doskey gcm=git commit -m $*
doskey giche=git checkout $*
doskey gpom=git push origin master $*
doskey exp=explorer $*
::doskey gitlog=git log --date=format:"%%Y-%%m-%%d %%H:%%M" --pretty=format:"%%h%%x09%%ai%%x09%%Cblue%%s%%x0D"
doskey gitlog=git log --pretty=format:"%%h%%x09%%ai%%x09%%Cblue%%s%%x0D"
:: Notice "%%h" instead of "%h" AND "%%x0D" in the end - a fix for batch script.
doskey colors="C:\Users\2\Documents\Task-Stack-Widget\task-data\colors.bat"
:: QUICK CD NAVIGATE SHORTCUTS.
doskey f1=cd C:\Users\2\Documents\Task-Stack-Widget\ 
doskey f2=cd C:\Users\2\Documents\Task-Stack-Widget\task-data\
doskey f3=cd C:\
doskey reboot=shutdown /f /r
doskey gpu=git push origin master
doskey gpull=git pull origin master
doskey sleep=rundll32.exe powrprof.dll,SetSuspendState 0,1,0
doskey rovlc= "C:\Users\2\Documents\Task-Stack-Widget\task-data\1268\drops_moc_fild11_3_snap_nolightmap_20fps.mp4"
doskey tsw=C:\Users\2\Documents\Task-Stack-Widget\run.bat
doskey ildasm="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\ildasm.exe" $*
doskey csc324="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe" $*
doskey csc="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe" $*
doskey csc644="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe" $*

doskey f4=cd C:\Windows\Microsoft.NET
doskey ilasm644="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ilasm.exe" $*
doskey ilasm324="C:\Windows\Microsoft.NET\Framework\v4.0.30319\ilasm.exe" $*
doskey mdbg="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\MDbg.0.1.0\tools\Mdbg.exe" $*
doskey f5=cd C:\Users\2\Documents\Task-Stack-Widget\task-data\1206
doskey wherecontexmenu=type C:\Users\2\Documents\Task-Stack-Widget\task-data\1282\wherecontexmenu.txt
doskey dja="C:\Python36-64\Scripts\django-admin.exe" $*
doskey cl="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\cl.exe" $*
doskey msvcdir=cd C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
doskey task=cd C:\Users\2\Documents\Task-Stack-Widget\task-data\$1
doskey vcvars32="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat"
doskey vcvars64="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
doskey vcvarsall="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat"
doskey gcl="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd" $*
doskey expcd=explorer %cd%
doskey gstop="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd compute instances stop instance-5"
doskey gstop2="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd compute instances stop instance-6"
doskey gstart="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd compute instances start instance-5"
doskey gstart2="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd compute instances start instance-6"
doskey gcloud="C:\Users\2\AppData\Local\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.cmd" $*
