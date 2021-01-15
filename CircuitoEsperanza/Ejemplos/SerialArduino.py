import serial
import json
import time
with open('mockProgram.json') as json_file:
    data = json.load(json_file)
    strData = str(data)+'\n'
    print("Enviado:",strData.encode('ascii'))
    arduino = serial.Serial('/dev/ttyACM0', 9600, timeout=5)
    time.sleep(2)
    if(arduino.is_open):
        error = False
        try:
            arduino.write(strData.encode('ascii'))
            # arduino.flush()
            print("datos enviados")
            for i in range(3):    
                line = arduino.readline()
                if(line):
                    print("Recived:",line)
                else:
                    print("Sin respusta")
        except Exception as e:
            print(e)
        finally:
            arduino.close()

    

