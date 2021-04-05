* DOSKEYS (permanent aliases)  
  * https://superuser.com/questions/1134368/create-permanent-doskey-in-windows-cmd
  * HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\
    * New String Value "Autorun"
    * Right-click -> Modify -> Value data -> DOSKEY /MACROFILE="C:\bat\macros.doskey"
* keyrate.cmd [taken from SoF](http://stackoverflow.com/a/11056655)
  * doskey kr=%USERPROFILE%\scripts\keyrate\keyrate.cmd $*
    * kr 140 45
	  * This makes keyboard fast.