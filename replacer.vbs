Dim fso,strFilename,strSearch,strReplace,objFile,oldContent,newContent
Set fso=CreateObject("Scripting.FileSystemObject")
Dim objShell
Set objShell = CreateObject("Wscript.Shell") 

Function ReplaceParticularValueInFileInLineAfterEqualSign(strFilename, strLineBeginning, strNewValue, whichToReplace)
    'whichToReplace - which occurence of the value to replace.
    '   (if we have several lines with the same key, 
    '    like in abcd setting.ini)
    Set fso=CreateObject("Scripting.FileSystemObject")
    strBackupFilename = strFilename & ".backup"
    if fso.FileExists(strFilename)=false then
        Msg = "File not found :"
        Msg = Msg & vbCrlf & strFilename
        MsgBox Msg
        Wscript.Quit
    end if
    fso.CopyFile strFilename, strBackupFilename
    tmpFilename = strFilename & ".TMP"
    If fso.FileExists(tmpFilename) Then
        Set tmpFile = fso.OpenTextFile(tmpFilename,2)
    Else
        Set tmpFile = fso.CreateTextFile(tmpFilename)
    End if
    set objFile=fso.OpenTextFile(strFilename,1)
    occured = 0
    Do Until objFile.AtEndOfStream
        line = objFile.ReadLine
        If InStr(line, strLineBeginning) = 1 Then
            'found target key, replacing its value within tmp file.
            occured = occured + 1
            'only replace if we met the target key whichToReplace times.
            if occured = whichToReplace Then
                line = Left(line,InStr(line, "=") ) & strNewValue
            end if
        End if    
        tmpFile.WriteLine line
    Loop
    Wscript.Sleep 300
    tmpFile.Close
    Wscript.Sleep 300
    objFile.Close
    Wscript.Sleep 300
    'true to overwrite
    fso.CopyFile tmpFilename, strFilename, True
    Wscript.Sleep 300
End Function

Function ReplaceInFile(strFilename, strSearch, strReplace)
    Set fso=CreateObject("Scripting.FileSystemObject")
    'fso.CopyFile "配置.ini", "backup-配置.ini"
    strBackupFilename = strFilename & ".backup"
    if fso.FileExists(strFilename)=false then
        Msg = "File not found :"
        Msg = Msg & vbCrlf & strFilename
        MsgBox Msg
        Wscript.Quit
    end if
    fso.CopyFile strFilename, strBackupFilename

    'Read file
    set objFile=fso.OpenTextFile(strFilename,1)
    oldContent=objFile.ReadAll
    Wscript.Sleep 300
    objFile.Close
    'Write file
    newContent=replace(oldContent,strSearch,strReplace,1,-1,0)
    set objFile=fso.OpenTextFile(strFilename,2)
    objFile.Write newContent
    Wscript.Sleep 300
    objFile.Close
    Wscript.Sleep 300
End Function



Function ReplaceLineInFile(strFilename, strSearch, strReplace)
    Set fso=CreateObject("Scripting.FileSystemObject")
    'fso.CopyFile "配置.ini", "backup-配置.ini"
    strBackupFilename = strFilename & ".backup"
    if fso.FileExists(strFilename)=false then
        Msg = "File not found :"
        Msg = Msg & vbCrlf & strFilename
        MsgBox Msg
        Wscript.Quit
    end if

    fso.CopyFile strFilename, strBackupFilename


    tmpFilename = strFilename & ".TMP"
    If fso.FileExists(tmpFilename) Then
        Set tmpFile = fso.OpenTextFile(tmpFilename,2)
    Else
        Set tmpFile = fso.CreateTextFile(tmpFilename)
    End if
    
    set objFile=fso.OpenTextFile(strFilename,1)
    Do Until objFile.AtEndOfStream
        line = objFile.ReadLine
        If InStr(line, strSearch) > 0 Then
            'found target line, replacing it within tmp file.
            line = strReplace
        End if    
        'tmpFile.Write line & vbCrlf
        tmpFile.WriteLine line
    Loop
    Wscript.Sleep 300
    tmpFile.Close
    Wscript.Sleep 300
    objFile.Close
    
    Wscript.Sleep 300
    'overwrite
    fso.CopyFile tmpFilename, strFilename, True
    Wscript.Sleep 300
End Function

Function ReplaceValueInFileInLineAfterEqualSign(strFilename, strLineBeginning, strNewValue)
    'fso.CopyFile "配置.ini", "backup-配置.ini"
    Set fso=CreateObject("Scripting.FileSystemObject")
    strBackupFilename = strFilename & ".backup"
    if fso.FileExists(strFilename)=false then
        Msg = "File not found :"
        Msg = Msg & vbCrlf & strFilename
        MsgBox Msg
        Wscript.Quit
    end if
    fso.CopyFile strFilename, strBackupFilename
    tmpFilename = strFilename & ".TMP"
    If fso.FileExists(tmpFilename) Then
        Set tmpFile = fso.OpenTextFile(tmpFilename,2)
    Else
        Set tmpFile = fso.CreateTextFile(tmpFilename)
    End if
    set objFile=fso.OpenTextFile(strFilename,1)
    Do Until objFile.AtEndOfStream
        line = objFile.ReadLine
        If InStr(line, strLineBeginning) = 1 Then
            'found target key, replacing its value within tmp file.
            line = Left(line,InStr(line, "=") ) & strNewValue
        End if    
        tmpFile.WriteLine line
    Loop
    Wscript.Sleep 300
    tmpFile.Close
    Wscript.Sleep 300
    objFile.Close
    Wscript.Sleep 300
    'true to overwrite
    fso.CopyFile tmpFilename, strFilename, True
    Wscript.Sleep 300
End Function

Function ReplaceLineInFileInLine(strFilename, strLineBeginning, strReplace)
    Set fso=CreateObject("Scripting.FileSystemObject")
    'fso.CopyFile "配置.ini", "backup-配置.ini"
    strBackupFilename = strFilename & ".backup"
    if fso.FileExists(strFilename)=false then
        Msg = "File not found :"
        Msg = Msg & vbCrlf & strFilename
        MsgBox Msg
        Wscript.Quit
    end if

    fso.CopyFile strFilename, strBackupFilename


    tmpFilename = strFilename & ".TMP"
    If fso.FileExists(tmpFilename) Then
        Set tmpFile = fso.OpenTextFile(tmpFilename,2)
    Else
        Set tmpFile = fso.CreateTextFile(tmpFilename)
    End if
    
    set objFile=fso.OpenTextFile(strFilename,1)
    Do Until objFile.AtEndOfStream
        line = objFile.ReadLine
        If InStr(line, strLineBeginning) = 1 Then
            'found target line, replacing it within tmp file.
            line = strReplace
        End if    
        'tmpFile.Write line & vbCrlf
        tmpFile.WriteLine line
    Loop
    Wscript.Sleep 300
    tmpFile.Close
    Wscript.Sleep 300
    objFile.Close
    
    Wscript.Sleep 300
    'overwrite
    fso.CopyFile tmpFilename, strFilename, True
    Wscript.Sleep 300
    'set fso = Nothing
End Function

Function WriteToLog(logFileName, strLogRecord)
    'simply append smth to log file.
    If fso.FileExists(logFileName) Then
        Set logFile = fso.OpenTextFile(logFileName,8)
    Else
        Set logFile = fso.CreateTextFile(logFileName)
    End if
    logFile.WriteLine strLogRecord
    Wscript.Sleep 100
    logFile.Close
    Wscript.Sleep 100
    Set logFile = Nothing
End function

Function CreateShortcut(source,workdir,destination,name)
    'EXAMPLE:
    '   CreateShortcut "D:\auto\checker.exe" ,
    '                  "D:\auto" ,
    '                  "C:\Users\Nur\Desktop\checker" ,
    '                  "checker"
    
    Set objShell = WScript.CreateObject("WScript.Shell")
    Set lnk = objShell.CreateShortcut(destination & ".LNK")
    lnk.TargetPath = source
    lnk.Arguments = ""
    lnk.Description = name
    'lnk.HotKey = "ALT+CTRL+F"
    'lnk.IconLocation = "C:\Program Files\MyApp\MyProgram.EXE, 2"
    'lnk.IconLocation = "C:\Program Files\MyApp\MyProgram.EXE, 2"
    'lnk.WindowStyle = "1"
    lnk.WorkingDirectory = workdir
    lnk.Save
    'Clean up 
    Set lnk = Nothing
End function

Function RunCmd(cmd)
    Set objShell = WScript.CreateObject("WScript.Shell")
    objShell.Run cmd, 1
End function





Function AppendToFile(destination, line)
    'AppendToFile "C:\Users\Kalum\Desktop\test-append-file.txt", "TEST"
    If fso.FileExists(destination) Then
        Set oFile = fso.OpenTextFile(destination,8)
    Else
        Set oFile = fso.CreateTextFile(destination)
    End if
    oFile.WriteLine line
    oFile.Close
    set oFile = Nothing
End function



Function ExecCmd(cmd)
    'EXAMPLE:
    '   cmd = "wmic process where name='cmd.exe' get ProcessID"
    '   MsgBox ExecCmd(cmd)
    'options(edit function body):
    '   [NOT USED]waitMillisec = 5000 by default.
    '   sleepDelay = 10 by default.
    '   maxExecCounter = 2 by default
    
    sleepDelay = 100
    maxExecCounter = 20
    strOutput = "Command failed."
    done = False
    execCounter = 0
    
    Set objShellLocal = WScript.CreateObject("WScript.Shell")
    set execLocal = objShellLocal.Exec(cmd)
    
    Do Until done
        if execCounter > maxExecCounter Then
            strOutput  = "Waited for too long"
            done = True
        end if
        
        
        if execLocal.Status = 1 Then
            done = True
        End if
        if execLocal.Status = 2 Then
            done = True
        End if
        
        execCounter = execCounter + 1
        
        if done = False Then
            Wscript.Sleep sleepDelay
        end if
    Loop

    Const statusWaiting = 0
    Const statusDone = 1
    Const statusFailed = 2

    status = CInt(execLocal.Status)
    Select Case status
        Case statusWaiting
            strOutput  = "Waited for too long"
        Case statusDone
            strOutput = execLocal.StdOut.ReadAll
        Case statusFailed
            strOutput = execLocal.StdErr.ReadAll
    End Select

    ExecCmd = strOutput
End function


Function GetVt
    Set fso=CreateObject("Scripting.FileSystemObject")
    vt = 1
    Do Until fso.FileExists("Z:\" & CStr(vt) & "vt" & "\SMTH.txt")
        If vt > 25 Then
            tmpFilename =  "Z:\fil\Log.txt"
            If fso.FileExists(tmpFilename) Then
                Set tmpFile = fso.OpenTextFile(tmpFilename,8)
            Else
                Set tmpFile = fso.CreateTextFile(tmpFilename)
            End if            
            set objFile=fso.OpenTextFile("C:\Users\Sahil\Desktop\Creater\settings.ini",1)
            Do Until objFile.AtEndOfStream
                line = objFile.ReadLine
                If InStr(line, "things.txt") > 0 Then
                    vtOther = Left(Mid(line,InStr(line,"Z:")+3), InStr(Mid(line,InStr(line,"Z:")+3),"things")-2)
                End if    
            Loop
            objFile.Close
            tmpFile.WriteLine vtOther & vbTab & CStr(Now())
            tmpFile.Close
            vt = vtOther
            Exit Do
            'MsgBox "Corrupted script: no ""[vt]"" folder found!"
        End if
        vt = vt + 1
    Loop
    GetVt = vt
End Function

'determine 

'vt = GetVt()

'RunCmd("wmic process where ""name='svchost.exe' and SessionId=1"" delete")
'RunCmd("wmic process where ""name='checker.exe' and SessionId=1"" delete")
'RunCmd("wmic process where ""name='conhost.exe' and SessionId=1"" delete")
'RunCmd("wmic process where ""name='cmd.exe' and SessionId=1"" delete")
'Wscript.Sleep 1000

For Each oFile in fso.GetFolder(sFolder).Files
    If UCase(fso.GetExtensionName(oFile.Name)) = "INI" Then
        needToDelete = True
        If oFile.Name = "时间.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "国际一键老头火焰迷宫.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "设置.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "NewTestFile.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "configure.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "protein_cure_find.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "patients__log.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "genetic_model_access_key.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "set_default_genetics_for_this_specimen.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "eliminate_dangerous_mutant.ini" Then
            needToDelete = False
        End if
        If oFile.Name = "call_military_forces.ini" Then
            needToDelete = False
        End if
        '"总控设置"
        '"国际一键老头火焰精华带升华迷宫"
        '"NewTestFile"
        '"Map"
        '"login_log"
        '"key"
        '"default"
        '"configure"
        '"aaa"
        '"bb"
        'MsgBox oFile.Name
        if needToDelete = True Then
            fso.DeleteFile(oFile.Path)
        end if
    End if
Next
        
On Error Resume Next




ReplaceValueInFileInLineAfterEqualSign "D:\lab\runner.ini","Key_file","X:\vadim_smirnov\key.biohazard"
ReplaceValueInFileInLineAfterEqualSign "D:\lab\runner_x.ini","Key_file","X:\vadim_smirnov\key.biohazard_x"

ReplaceLineInFile "C:\Windows\win_settings.txt","attrib1","value1"




RunCmd("D:\checker.exe")
RunCmd("""C:\Users\Nur\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\batnik.bat""")

