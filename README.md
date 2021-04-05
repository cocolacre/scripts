DOSKEYS (permanent aliases)  
* https://superuser.com/questions/1134368/create-permanent-doskey-in-windows-cmd
* HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\
  * New String Value "Autorun"
  * Right-click -> Modify -> Value data -> DOSKEY /MACROFILE="C:\bat\macros.doskey"
