import sys
import PyQt5
from PyQt5.QtWidgets import QApplication, QLabel, QWidget
from PyQt5.QtCore import QThread, QTimer
from PyQt5.QtCore import pyqtSlot
from PyQt5.QtCore import pyqtSignal
import keyboard
import time, random, os
import signal

class Window(QWidget):
    """
    TODO: session comments from user, db, photo, pulse, reaction interval extraction from raw data...
    
    CURRENTLY: reaction time = key_pressed_at - shown_at
    
    """
    time_to_start_timer = pyqtSignal()
    
    def __init__(self, num_measurements=10):
        super(QWidget, self).__init__()
        keyboard.on_press(self.hook_callback, suppress=False)
        self.setWindowTitle('Measure Physiological reactiom time. v1.')
        self.num_measurements = num_measurements
        #helloMsg = QLabel('<h1>Hello World!</h1>', parent=self)
        self.window_w = 640
        self.window_h = 480
        self.window_x0 = 200
        self.window_y0 = 200
        
        self.setGeometry(self.window_x0, self.window_y0, self.window_w, self.window_h)
        self.signal = QLabel("Press SPACE", parent = self)
        self.signal_info = "Signal info: QLabel, 'Press SPACE', default font size"
        self.signal.move(self.window_w/2,self.window_h/2)
        self.timer = QTimer()
        #self.timer.timeout.connect(self.show_and_continue)
        self.signal.hide()
        self.wait_for_keypress = False
        self.key_presses = []
        self.counter = 0
        self.measurements = []
        self.new_interval = 3.0
        self.time_to_start_timer.connect(self.start_timer)
        ### !!! ### This signal-slot connection is not thread safe and needs to be fixed.
        ### Until then - we will ignore errors in the output (script still works for some reason)
        self.timer.timeout.connect(self.show_and_continue)
        self.new_measurement()
    
    #@pyqtSlot(int)
    def start_timer(self):
        self.timer.start()
        
    def new_measurement(self):
        self.new_interval = 2 + 4.0*random.random()
        self.timer.setInterval(int(self.new_interval*1000))
        print("waiting new interval:", self.new_interval)
        self.measurements.append({ "new_interval" : self.new_interval} )
        self.measurements[-1]["counter"] = self.counter
        self.measurements[-1]["new_interval_set_at"] = time.time()
        self.signal.hide()
        self.measurements[-1]["hidden_label_at"] = time.time()
        #self.timer.start()
        self.time_to_start_timer.emit()
        self.measurements[-1]["timer_started_at"] = time.time()
        #now wait until space button is pressed next time.
        
    def show_and_continue(self):
        self.signal.show()
        self.measurements[-1]["shown_at"] = time.time()
        self.wait_for_keypress = True
        #self.key_presses = []
        
    def hook_callback(self,*args):
        #print((name,scan_code,time))
        #print("event.name:",event.name, "\t\t\t\t",event.scan_code, event.time)
        #print(dir(args))
        #print(args[0].event_type)
        
        if self.wait_for_keypress:
            event = args[0]
            if event.event_type == "down":
                # keypress done!
                self.measurements[-1]["key_pressed_at"] = time.time()
                self.measurements[-1]["reaction_time"] = self.measurements[-1]["key_pressed_at"] - self.measurements[-1]["shown_at"]
                self.wait_for_keypress = False 
                
                self.counter+=1
                
                if self.counter > self.num_measurements: #finish if counter exceeded planned measurements amount
                    print("Unhooking ... ")
                    keyboard.unhook_all()
                    keyboard.unhook_all_hotkeys()
                    num_files = len(os.listdir())
                    
                    #print(self.measurements[:-1])
                    reaction_times = [measurement['reaction_time'] for measurement in self.measurements[:-1]]
                    reaction_time_min = min(reaction_times)
                    reaction_time_max = max(reaction_times)
                    reaction_time_avg = sum(reaction_times)/len(self.measurements[:-1])
                    
                    with open("measurement_" + str(num_files+1) + ".txt", "a+") as report:
                        report.write(time.ctime() + "\n")
                        report.write(self.signal_info + "\n")
                        report.write("reaction_time_min:\t" + str(reaction_time_min) + "\n")
                        report.write("reaction_time_max:\t" + str(reaction_time_max) + "\n")
                        report.write("reaction_time_avg:\t" + str(reaction_time_avg) + "\n")
                        report.write("### DATA: ###\n")
                        for item in self.measurements[:-1]: #drop last record
                            for k,v in item.items():
                                report.write(str(k) + "\t" + str(v))
                                report.write("\n")
                            report.write("\n")
                        report.write("#"*12 + "\n")
                    self.close()
                else:
                    self.new_measurement()

if __name__ == "__main__":
    pid = os.getpid()
    app = QApplication(sys.argv)
    window = Window()
    window.show()
    try:
        sys.exit(app.exec_())
        os.kill(os.getpid(), signal.SIGTERM)
        #pass
        #os.system('taskkill /f /PID %d'%pid)
    except Exception as _e: #if we are on Linux for example...
        pass
        
