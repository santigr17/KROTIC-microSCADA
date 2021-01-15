#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "FamiliaGR";
const char* password =  "28Familiagr";

const char* mqttServer = "broker.hivemq.com";
const char * clientID = "esp8266KROTIC";
const int mqttPort = 1883;//Mosquitto default
const char* mqttUser = "";
const char* mqttPassword = "";
const char* listen_topic = "krotic/arduino1";
const char* publish_topic = "krotic/arduino2";



WiFiClient wifiClient;
void MQTT_callback(char* topic, byte* payload, unsigned int length);
PubSubClient client(wifiClient);

void reconnect();

void setup() {
  // initialize serial for debugging
  Serial.begin(115200);
  
  delay(100);

 WiFi.begin(ssid, password);
//  Serial.println("Connecting to WiFi..");
  while (WiFi.status() != WL_CONNECTED) {
    delay(700);
//    Serial.print(".");
    
  }
//  Serial.println("Connected to the WiFi network");
  
  client.setServer(mqttServer, 1883);
  client.setCallback(MQTT_callback);
  
  while (!client.connected()) {
//    Serial.println("Connecting to MQTT...");
    //if (client.connect(clientID, mqttUser, mqttPassword )) {
    if (client.connect(clientID)) {
//      Serial.println("connected");
    } else {
//      Serial.print("failed with state ");
//      Serial.print(client.state());
      delay(2000);
    }
  }
  if(client.subscribe(listen_topic)){
    Serial.println("Suscribed");
  }
  
  if (client.publish(publish_topic, "hello from ESP8266")) {
    Serial.println("Publish ok");
  }
  else {
    Serial.println("Publish failed");
  }  

  
}

String inputString = "";

void loop() {
  if (!client.connected()) {
//    Serial.println("Desconexion");
    reconnect();
  }
  
  client.loop();
  if(Serial.available()){
    while (Serial.available()) {
      // get the new byte:
      char inChar = (char)Serial.read();
      // add it to the inputString:
      inputString += inChar;
      // if the incoming character is a newline, set a flag so the main loop can
      // do something about it:
      if (inChar == '\n') {
        client.publish(publish_topic, inputString.c_str());
        inputString = "";
      }
    }
  }
  delay(500);
}

 

//print any message received for subscribed topic
void MQTT_callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i=0;i<length;i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}


void reconnect() {
  while (!client.connected()) {
    if (client.connect(clientID)) {
      client.subscribe(listen_topic);
      break;
    } else {
      delay(5000);
    }
  }
}
