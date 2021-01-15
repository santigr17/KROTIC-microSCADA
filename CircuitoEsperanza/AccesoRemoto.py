# BIBLIOTECAS
import paho.mqtt.client as mqtt 
import pyrebase
import json

# MODULOS  
import CircuitoEsperanza as CE

# Configuración con la aplicación de firebase
firebaseConfig = {
    "apiKey": "AIzaSyCAThVaCCR-h0D5nTK5XeFWQfeUuY-wPMk",
    "authDomain": "krotic-web-server.firebaseapp.com",
    "databaseURL": "https://krotic-web-server.firebaseio.com",
    "projectId": "krotic-web-server",
    "storageBucket": "krotic-web-server.appspot.com",
    "messagingSenderId": "609691878481",
    "appId": "1:609691878481:web:b8fa441251a2c9fb71e470",
    "measurementId": "G-C14ZZHR3J0",
    "serviceAccount": "/home/pi/kroticAuth/krotic-web-server-firebase-adminsdk-fw7tm-2e7a5c0511.json"
} #sericeAccount es un json generado en firebase para autenticacion de administrador



# MQTT topic para subscribir y publicar a los dispositivos
topicArduino = 'itcr/lutec/krotic/Arduino'
topicCircuitoEsperanza = 'itcr/lutec/krotic/CircuitoEsperanza'
topicWebApp = 'itcr/lutec/krotic/WebApp'

# INSTANCIAS PRINCIPALES
client = mqtt.Client()
pista = CE.CircuitoEsperanza()  # Instancia para manejar las camaras y variables de la pista

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected success")
        client.subscribe(topicCircuitoEsperanza)
        print("Suscrito a " + topicCircuitoEsperanza)
        client.publish(topicArduino, payload = "{\"conexion\":\"CircuitoEsperanza\",\"status\":\"online\"}", qos=0, retain=False)
        client.publish(topicWebApp, payload = "{\"conexion\":\"CircuitoEsperanza\",\"status\":\"online\"}", qos=0, retain=False)    
    else:
        print(f"Connected fail with code {rc}")


def on_message(client, userdata, msg):
    print(f"{msg.topic} {msg.payload}")
    try:
        comando = json.loads(msg.payload)
        if(comando["cmd"] == "Grabar"):
            pista.iniciarGrabacion()
        
        elif(comando["cmd"] == "Detener"):
            pista.detenerGrabacion()
        
        elif(comando["cmd"] == "Status"):
            respuesta = ""
            status = pista.checkCamaras()
            if(status == []):
                respuesta = "{\"Status\":\"ok\""
            else:
                respuesta.append("{\"Status\":{}".format(str(status)))

            client.publish(topicWebApp, payload = respuesta, qos=0, retain=False)    
        
        elif(comando["cmd"] == "Subir videos"):

        elif(comando["cmd"] == "Publicar"):
            pass



    except Exception as e:
        print("Error json recibido.\nERROR: ",str(e))
    


client.on_connect = on_connect
client.on_message = on_message
client.connect('broker.hivemq.com', 1883, 60) 
# client.will_set('raspberry/status', b'{"status": "Off"}')
client.loop_forever()