# test_connect.py 
import paho.mqtt.client as mqtt 

topic = "itcr/lutec/krotic/circuito_esperanza"
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected success")
        client.subscribe(topic)
        print("Suscrito a "+topic)
    else:
        print(f"Connected fail with code {rc}")
def on_message(client, userdata, msg):
    print(f"{msg.topic} {msg.payload}")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.will_set('raspberry/status', b'{"status": "Off"}')
client.connect('broker.hivemq.com', 1883, 60) 
client.loop_forever()