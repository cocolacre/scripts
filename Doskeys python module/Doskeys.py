#Include doskey scripting into TSW-1.py

#import doskeys
#from doskeys import Doskeys
import os
class Doskeys():
    def __init__(self,*args,**kwargs):
        self.print_arguments(*args,**kwargs)
    def select_or_create_doskeys_bat(self,*args,**kwargs):
        self.print_arguments(*args,**kwargs)
        self.path = os.curdir
        self.doskeys_bat_filename = "doskeys.bat"
        with open(self.doskeys_bat_filename, "r") as fin:
            self.doskeys_bat_lines = fin.readlines()
            self.doskeys_bat_doskeys_lines = [{x[7:x.find("=")].strip(): x[x.find("=")+1:].strip() } for x in self.doskeys_bat_lines if "doskey" in x[:7]]
            print(self.doskeys_bat_doskeys_lines)
            
    def print(self,*args,**kwargs):
        self.print_arguments(*args,**kwargs)
    def print_arguments(self,*args,**kwargs):
        print(len(args))
        print(len(kwargs))
        print("args:",args)
        print("kwargs:",kwargs)
    def help(self,*args,**kwargs):
        #print("Help message")
        print("Нэхтэжэ илия мусэйфунэ")
        
doskeys = Doskeys(os.sys.version)

params = (True, False, "default")
#doskeys.select_or_create_doskeys_bat(*params)
doskeys.select_or_create_doskeys_bat(*params)
doskeys.print()
doskeys.help()
#showing gui\printing info
#show gui doskeys panel
class DoskeysSettingsPanel():
    def __init__(self,**kwagrs):
        self.meth_show_gui()

    def meth_show_gui():
        print("self.meth.show_gui")
