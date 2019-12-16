# by cocolacre 
# created 15.12.2019 16:40 
# Requires PyQt4 and sip.
# Tested on Windows 10 and Python 3.6 (64-bit).
# If given administrative rights - works a little better.(see below)
# Uses <servers.txt> within the same folder as a data source.
# Each line of servers.txt must be as following:
# serverAddress username password
# 
# Utilizes mstsc.exe - a standard Windows RDP tool.
# No error\exception handling.
# (not optimized for more than 15-20 servers in servers.txt)
# (this is a dirty hour-spent hack made to avoid juggling with .rdp files)
# ...(hopefully saving couple of minuts in the long run)
# (with each minute being ~1.9*60 tribe members' deaths)

import sip
sip.setapi('QString', 1)
from PyQt4 import QtCore, QtGui,QtSql, QtTest
import sys 
from PyQt4.QtCore import *
from PyQt4.QtGui import *
import subprocess as sp
import os

class ServerButton(QtGui.QPushButton):
    """
    Custom buttons.
    """
    def __init__(self,server,parent=None):
        super(ServerButton, self).__init__(server['host'])
        self.server = server
        self.host = self.server['host']
        self.username = self.server['username']
        self.password = self.server['password']
        self.pid = 0 #pid of the RDP session client.
        self.timer = QtCore.QTimer()
        self.check_interval = 300 #seconds
        self.timer.setInterval(self.check_interval * 1000)
        self.timer.timeout.connect(self.check_process)
        self.started = False
        self.setText(str(self.text()) + ': OFF')
        self.has_admin_rights = False
        
    def start_rdp(self):
        OPT = 1 # dirty development process artifact.
        cmd1 = 'cmdkey /generic:"{0}" /user:"{1}" /pass:"{2}"'
        cmd1 = cmd1.format(self.host,self.username,self.password)
        cmd2 = "mstsc /v:{0} /admin".format(self.host)
        if OPT == 0:    
            sp.call(cmd1,shell=True)
            sp.call(cmd2,shell=True)
        elif OPT ==1:
            sp.call(cmd1,shell=True)
            proc = sp.Popen(cmd2)
            print('RDP pid:'+str(proc.pid))
            self.pid = int(proc.pid)
        self.started = True
        self.timer.start()
        
        self.setText(str(self.text())[:-5] + ': ON ')
        
    def check_process(self):
        if self.pid == 0:
            return False
        cmd = 'tasklist /FI "PID eq {0}'.format(self.pid)
        res = sp.run(cmd,stdout=sp.PIPE).stdout.decode('utf-8')
        if 'criteria' in res:
            #RDP SESSION PROCESS NOT FOUND
            print('RDP SESSION {0}PROCESS NOT FOUND'.format(self.host))
            self.timer.stop()
            self.started = False
            self.pid = 0
            self.setText(str(self.text())[:-5] + ': OFF')
        else:
            print('RDP session {0} found.'.format(self.host))
            #cmd = 'netstat -n -o -b -a | findstr {0}'.format(self.pid)
            
            if self.has_admin_rights: #check connection.
                #and kill RDP process if needed.
                cmd = 'netstat -n -o -b -a'
                res = sp.run(cmd,stdout=sp.PIPE).stdout.decode('utf-8')
                #print(cmd+'\n'+res)
                if str(self.host) in res:
                    print('connection okay')
                else:
                    print('connection is dead. killing process')
                    res = sp.run('taskkill /F /PID {0}'.format(self.pid),stdout=sp.PIPE)
                    self.timer.stop()
                    self.started = False
                    self.pid = 0
                    self.setText(str(self.text())[:-5] + ': OFF')

    def activate_window(self):
        #NYI
        pass
    
    def check_connection(self):
        #NYI
        pass
    
    def close_disconnected_session(self):
        #NYI
        pass
    
class RDP_Panel(QtGui.QWidget):
    def __init__(self):
        super(RDP_Panel, self).__init__()
        self.setWindowTitle('Jitovoz Legion Overwatch')
        self.setFixedWidth(400)
        self.move(0,0)
        filename = "servers.txt" 
        #store server creds in this file with each line being like:
        #<hostadress> <username> <password>
        self.servers = []
        self.last_clicked = None
        self.has_admin_rights = self.check_admin()
        self.server_buttons = []
        
        with open(filename,'r') as f:
            data = [line.strip() for line in f.readlines()]
            for line in data:
                if len(line) < 2:
                    continue
                server_info = line.split(' ')
                server = {}
                server['host'] = server_info[0]
                server['username']=server_info[1]
                server['password']=server_info[2]
                self.servers.append(server)
        self.servers.sort(key=lambda x: int(x['host'].split('.')[3]))
        self.vbox = QtGui.QVBoxLayout()
        self.setLayout(self.vbox)
        for server in self.servers:
            server_button = ServerButton(server)
            server_button.has_admin_rights = self.has_admin_rights
            self.vbox.addWidget(server_button)
            server_button.clicked.connect(server_button.start_rdp)
            self.server_buttons.append(server_button)
            
        self.refresh_button = QtGui.QPushButton('Refresh')
        self.vbox.addWidget(self.refresh_button)
        self.refresh_button.clicked.connect(self.refresh_connections)
        self.vbox.addWidget(QtGui.QPushButton('[NYI][Arrange windows]'))
        self.vbox.addWidget(QtGui.QPushButton('[NYI][Save|load session]'))
        self.vbox.addWidget(QtGui.QPushButton('[NYI][another placeholder]'))
        
        
    def refresh_connections(self):
        for server in self.server_buttons:
            #server.setText(server.text()+' *')
            server.check_process()
            #server.setText(server.text()[:-2])
            
            
    def check_admin(self):
        # taken from here:
        # https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
        cmd1 = "net session >nul 2>&1"
        res = int(os.system(cmd1))
        if res != 0:
            print('No admin rights. RDP connections will not be monitored.')
            return False
        else:
            print('Admin rights detected. RDP connections will be monitored')
            return True

if __name__ == "__main__":
    import sys
    pid = os.getpid()
    app = QtGui.QApplication(sys.argv)
    win_main = RDP_Panel()
    win_main.show()
    app.exec_()
    os.system('taskkill /f /PID %d'%pid)
