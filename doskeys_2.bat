:: Windows Terminal page: https://learn.microsoft.com/en-us/windows/terminal/command-line-arguments?tabs=windows

@echo off

:: COLOR CODES: https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
:: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
:: https://github.com/fidian/ansi

:: ####################################################################
:: set ESC variable to invisible ESCAPE character.
::https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
::for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
::echo %ESC%[91m Red %ESC%[0m
::echo %ESC%[94m Blue %ESC%[0m
::echo %ESC%[91m My text in Red. %ESC%[0m
:: ####################################################################
:: The lines below contain INVISIBLE "ESC" `character`


set `r=[0m
set `b=[1m
set `u=[4m
set `i=[7m
set black-=[30m
set red-=[31m
set green-=[32m
set yellow-=[33m
set blue-=[34m
set magenta-=[35m
set cyan-=[36m
set white-=[37m
set black=[90m
set red=[91m
set green=[92m
set yellow=[93m
set blue=[94m
set magenta=[95m
set cyan=[96m
set white=[97m

echo This is %yellow-%doskeys.bat%`r%
echo Don't forget to set [KEYRATE] via %cyan-%'kr 137 37'%`r% or whatever.

::chcp 65001
::color f1
::color 0a


doskey light=color f1
doskey green=color 0a

doskey p3="C:\Users\cocolacre\AppData\Local\Programs\Python\Python310\python.exe" $*
doskey p37="C:\Program Files\Python37\python.exe" $*

doskey tsw=cd C:\Users\cocolacre\Documents\Task-Stack-Widget $T$T "C:\Program Files\Python37\python.exe" TSW-1.py
doskey task=cd C:\Users\cocolacre\Documents\Task-Stack-Widget\task-data\$*

::doskey cgw=C:\cygwin64\bin\bash.exe

doskey mv=move $*
doskey cp=copy $*
doskey ls=dir

doskey dsks="C:\Program Files\Notepad++\notepad++.exe" %USERPROFILE%\doskeys.bat
doskey ld="%USERPROFILE%\doskeys.bat"

doskey npp="C:\Program Files\Notepad++\notepad++.exe" $*

doskey yt="C:\Users\cocolacre\AppData\Local\Programs\Python\Python310\Scripts\youtube-dl.exe" $*
doskey yd="C:\Users\cocolacre\AppData\Local\Programs\Python\Python310\Scripts\yt-dlp.exe" $*
doskey ypa=C:\Users\cocolacre\AppData\Local\Programs\Python\Python310\Scripts\yt-dlp.exe -f 140 $*
doskey qq=exit
doskey expcd=explorer %%cd%%

doskey keylog=cd %USERPROFILE%\Documents\Task-Stack-Widget\task-data\2780 $T$T C:\Python39\python.exe C:\Users\79951\Documents\Task-Stack-Widget\task-data\2780\keyboard-log-1.py
doskey winlog=cd %USERPROFILE%\Documents\Task-Stack-Widget $T$T C:\Python37\python.exe C:\Users\79951\Documents\Task-Stack-Widget\WindowWatcher.py

doskey cmak="C:\Program Files\CMake\bin\cmake.exe" $*

doskey geoip=curl https://ipinfo.io/$*

doskey ga=git add -A
doskey gcm=git commit -m $*

doskey kr=C:\Users\cocolacre\keyrate.cmd $*

doskey rar="C:\Program Files\WinRAR\Rar.exe" $*
doskey unrar="C:\Program Files\WinRAR\UnRar.exe" $*
doskey unzip=tar -xf $*

doskey hst=doskey /history

doskey restart=shutdown /r /t 0
doskey reboot=shutdown /r /t 0

