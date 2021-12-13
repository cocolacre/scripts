#import sip
#import gc
#sip.setapi('QString', 1)
from PyQt4 import QtCore, QtGui, QtTest,QtSql
import queue, copy
import sys,time
from PyQt4.QtCore import *
from PyQt4.QtGui import *
import subprocess as sp
import os,ctypes
import datetime
import sqlite3
#import cv2
import screen,keyboard
import uuid
from ctypes import wintypes as wt
#import clr
#import System.Diagnostics

class WindowsWatcher(QtCore.QObject):
    def __init__(self):
        super(QtCore.QObject, self).__init__()
        self.running =True
        self.dataPortion = 10
        self.timer = QtCore.QTimer()
        self.interval = 3000 #milliseconds
        #self.timer.setInterval(1000)
        self.updating = True
        #self.db = QtSql.QSqlDatabase.addDatabase('QSQLITE')
        #self.db.setDatabaseName('active_windows.db')
        #query = QtSql.QSqlQuery()
        #self.q=query
        self.conn = sqlite3.connect("active_windows.db")
        init_cmd = "CREATE TABLE IF NOT EXISTS active_windows(id integer primary key autoincrement, title varchar(1024), pid int, executable varchar(128), time_created varchar(24))"
        #self.ex(init_cmd)
        self.cur = self.conn.cursor()
        self.cur.execute(init_cmd)
        self.conn.commit()
        #self.conn.close()
    
    #def ex(self, cmd='',show=False):
    #    query = self.q
    #    if cmd == '':
    #        #cmd = "SELECT name FROM sqlite_master WHERE type in ('table',view')"
    #        pass
    #    res = self.q.prepare(cmd)
    #    if not res:
    #        print('ERROR! Bad query!')
    #        print(cmd)
    #    res = self.q.exec_()
    #    if show:
    #        self.show_query_result(query = self.q)
    #    return res

    def add_record(self, title, pid, executable, time_created):
        cmd = f"INSERT INTO active_windows VALUES(NULL,'{title}',{pid},'{executable}','{time_created}')"
        print("SQL INSERT:\n" + cmd)
        self.cur.execute(cmd)
        self.conn.commit()
        
        
        
    @pyqtSlot()
    def start_windows_watcher(self):
        #self.timer.start()
        prev_window_hwnd = 0
        prev_window_text = ''
        while self.running:
            QtTest.QTest.qWait(self.interval)
            hwnd = ctypes.windll.user32.GetForegroundWindow()
            window_text_length = ctypes.windll.user32.GetWindowTextLengthW(hwnd)
            buff = ctypes.create_unicode_buffer(window_text_length+1)
            res = ctypes.windll.user32.GetWindowTextW(hwnd, buff, window_text_length+1)
            #print(buff.value)
            #path_len = 200
            #path_buff = ctypes.create_unicode_buffer(path_len+1)
            #res = ctypes.windll.user32.GetWindowModuleFileNameW(hwnd, path_buff,path_len)
            #pid = ctypes.c_uint()
            #res = ctypes.windll.user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
            
            #print(pid.value)
            #process = System.Diagnostics.Process.GetProcessById(pid.value)
            #name = process.MainModule.FileName
            
            if self.updating:
                if prev_window_hwnd != hwnd or prev_window_text != str(buff.value):
                    prev_window_hwnd = hwnd
                    prev_window_text = str(buff.value)
                    #print(hwnd, window_text_length,buff.value, path_buff.value)
                    #print("["+str(buff.value)+"] ["+name+"]")
                    print(str(buff.value))
                    #del path_buff
                    #path_len = 512
                    #path_buff = ctypes.create_unicode_buffer(path_len+1)
                    #res = ctypes.windll.user32.GetWindowModuleFileNameW(hwnd, path_buff,path_len)
                    #print(str(path_buff.value))
                    pid = ctypes.c_uint()
                    res = ctypes.windll.user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
                    print(pid.value)
                    res = sp.check_output("tasklist.exe").decode("utf-8")
                    res = res.split("\r\n")
                    res = [list(filter(lambda y: y != "", x.split(" "))) for x in res if len(x) > 3]
                    #print(res)
                    #res = that x where x[1] == str(pid)
                    process_data = list(filter(lambda x: len(x) > 2 and x[1] == str(pid.value), res))
                    if len(process_data) > 0 and len(process_data[0]) > 0:
                        exe = process_data[0][0]
                    else:
                        exe = '???'
                    print(exe)
                    
                    self.add_record(str(buff.value), int(pid.value), exe, time.ctime())
                    
                    del hwnd
                    del buff
                    
ww = WindowsWatcher()
ww.start_windows_watcher()
