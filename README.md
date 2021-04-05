* DOSKEYS (permanent aliases)  
  * https://superuser.com/questions/1134368/create-permanent-doskey-in-windows-cmd
  * Go here: HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\
    * New String Value: "Autorun"
    * Value: "C:\Users\USERNNAME\scripts\doskeys.bat"
	* [TODO: add vbscript to automatically add registry record for this]
* keyrate.cmd [taken from SoF](http://stackoverflow.com/a/11056655)
  * doskey kr=%USERPROFILE%\scripts\keyrate\keyrate.cmd $*
    * kr 140 45
	  * This makes keyboard fast.