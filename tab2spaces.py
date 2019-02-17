# C:\Python27\Tools\Scripts\reindent.py script 
# doesn't work for me for some reason, so
# here's a quick solution for replacing tabs with spaces.
# (Don't show this to Richard!)
# It has not been tested well.
# Usage: py2 tab2spaces.py TAB_INFESTED_FILE.py
# it creates backup file named  TAB_INFESTED_FILE.py.backup
# and simply replaces all '\t' with '    ' within your file.
#     Windows only. 
# TODO: options(restore from backup; delete backups; process all files in dir; etc)

import sys,os
import subprocess as sp

help_string = """
USAGE:
Replace each tab with 4 spaces within a .py file
python2 tab2spaces.py [-b] FILENAME
python2 tab2spaces.py [-c]
    -b      restore file with tabs from [b]ackup.
    -c      [c]lean up .backup files 
"""
def spco(cmd):
    sp.check_output(cmd,shell=True)


def kill_process():
    pid = os.getpid()
    cmd = 'taskkill /f /PID %d'%pid
    os.system(cmd)

os.system('') #this is for enabling ASCII color codes on win7+.
#res = sp.check_output('', shell=True)

def red(text): #Works on win10, but we are not sure about other versions.
    red_text = '\033[91m'+text+' \033[39m'
    return red_text
def green(text):
    green_text = '\033[92m'+text+' \033[39m'
    return green_text

if len(sys.argv) == 2:
    option = sys.argv[1]
    if option in ['-h', '/?', '--help', '-help', '--h']:
        print help_string
        inp = raw_input('Press any key to continue...')
        kill_process()
    #deleting all backup files from dir.
    elif option == '-c':
        inp = raw_input('Are you sure to delete all backup files from directory? [y] ')
        if inp == 'n' or inp == '':
            kill_process()
        elif inp == 'y':
            res = spco("del *.backup")
        else:
            print red('Wrong input.Try again')
        kill_process()
    else:
        fname = option

#restoring backup file
elif len(sys.argv) == 3:
    fname = sys.argv[2]
    option = sys.argv[1]
    if option != '-b':
        print 'Wrong command!'
        print help_string
        inp = raw_input('Press any key to continue...')
        kill_process()
    else:
        if fname[-3:] != '.py': #check if file is a python script.
            print fname, ' - '+ red('wrong file type!')
            kill_process()

        backup_fname = fname+'.backup'
        if backup_fname not in os.listdir(os.getcwd()):
            print red('ERROR! Backup file not found!')
            kill_process()
        try:
            res = spco('move /Y %s %s'%(backup_fname, fname))
            print green('OK!')
            kill_process()
        except Exception as _e:
            print red('ERROR! Failed to restore backup')
            print str(_e)
            kill_process()

        print green('OK!')
        kill_process()

if fname[-3:] != '.py': #check if file is a python script.
    print fname, ' - '+ red('wrong file type!')
    kill_process()    
    sys.exit()

backup_fname = fname+'.backup'

#create backup file. "/B" flag is important.
res =spco('copy /B /Y %s %s'%(fname,  backup_fname))
ls = os.listdir(os.getcwd())


#check if backup file is present in current directory
if backup_fname not in ls: 
    print red('ERROR! Backup failed!')
    kill_process()

#check if backup file is of the same size
original_fsize = int(os.stat(fname).st_size)
backup_fsize = int(os.stat(backup_fname).st_size)
if original_fsize != backup_fsize:
    print red('ERROR! Backup produced wrong file size')
    kill_process()
#de-tab the file. 
else:
    nTabs = 0
    with open(fname, 'r') as f:
        lines = f.readlines()
    with open(fname, 'w') as f:
        deTabedLines = []
        for line in lines:
            nTabs = nTabs + line.count('\t')
            deTabedLine = line.replace('\t','    ')
            deTabedLines.append(deTabedLine)
        f.writelines(deTabedLines)

#check file sizes after operation
new_fsize = int(os.stat(fname).st_size)
fsize_delta = new_fsize- original_fsize
if nTabs == 0:
    delta_per_tab = 0
else:
    delta_per_tab = 1.0*(new_fsize- original_fsize)/nTabs

print 'replaced %d tabs; '%nTabs, 'size delta: %d Bytes total'%fsize_delta
print 'delta Bytes per replacement: %d'%delta_per_tab
if delta_per_tab !=3 and delta_per_tab !=0:
    print red('Wrong filesize after operation. Restoring from backup!')
    res = spco('del %s'%fname)
    res = spco('move %s %s'%(backup_fname, fname))
else:
    print green('OK!')
    
kill_process()