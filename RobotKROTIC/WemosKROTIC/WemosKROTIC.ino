/**
 * Instituto Tecnológico de Costa Rica
 * Computer Engineering   
 * Laboratorio LuTec
 * 
 * Autor: Santiago Gamboa Ramírez   
 * 
 * Creación: noviembre 2020   
 * Última modificación: enero 2021
 * 
 * Bibliotecas Instaladas:
 * - ArduinoJson 6.17.2
 * - StreamUtils 1.6.0
 * 
 * Convenciones:
 * - Nombre de funciones inicia en mayúsculas (excepto setup y loop)
 * - Constantes de valores no relacionados a pines en mayúscula, con guión bajo para separar palabras.   
 * - Constantes relacionadas a pines utilizan los sufijos:          
 *      . led : Led conectado, siempre es salida.          
 *      . pin : Pin de proposito general.          
 *      . btn : Botón conectado, siempre entrada.   
 * - Variables inician en minúscula
 * 
*/


#include <Servo.h>
#include <PubSubClient.h>
#include <StreamUtils.h>
#include <ArduinoJson.hpp>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>



// Definición de los pines
#define pinMotorA D5
#define pinMotorB D7
//#define pinSensorA A1
//#define pinSensorB A2
#define ledPinA D0
#define ledPinB D5
//#define btnStart 8




/**
 * ############################################################
 * # CONSTANTES PARA LA CONEXIÓN CON LA RED Y EL SERVIDOR MQTT#
 * ############################################################
 */

//Obligatorios
const char* ssid = "FamiliaGR";
const char* password =  "28Familiagr";
const char* mqttServer = "broker.hivemq.com";
const char * clientID = "esp8266KROTIC";

const int mqttPort = 1883;//Mosquitto default
//Depends on the broker you are connecting to. Default mosquitto doesn't have this authentication
const char* mqttUser = "";
const char* mqttPassword = "";

const char* topicArduino = "itcr/lutec/krotic/Arduino";
const char* topicCircuitoEsperanza = "itcr/lutec/krotic/CircuitoEsperanza";
const char* topicWebApp = "itcr/lutec/krotic/WebApp";


WiFiClient espClient;
PubSubClient client(espClient);
void MQTT_callback(char* topic, byte* payload, unsigned int length);
void reconnect();


/**
 * ###########################################
 * # CONSTANTES PARA EL MOVIMIENTO DEL ROBOT #
 * ###########################################
 */

// Dependiendo de los motores el valor puede variar 85 ~ 95.
#define VEL0_A 90 // 90° Equivalen a un pwm de 0 aproximadamente, lo que hace que el motor se detenga.
#define VEL0_B 90 // 180° max velocidad sentido horario, 0° máx vel sentido antihorario, 90° mitad es cero vel

/**
 * El máximo ángulo que se puede recorrer es el de 180°, los menores se recorren normalmente y
 * los mayores se resta 360 a la diferencia y cambia el sentido del giro.
 */
#define TIEMPO_ROTAR_45 280 // Tiempo para rotar el robot 45° con una carga máxima de batería
#define TIEMPO_ROTAR_90 780 // Tiempo para rotar el robot 90° con una carga máxima de batería
#define TIEMPO_ROTAR_135 1280  // Tiempo para rotar el robot 135° con una carga máxima de batería
#define TIEMPO_ROTAR_180 1560 // Tiempo para rotar el robot 180° con una carga máxima de batería


#define TIEMPO_AVANZAR_30 2500
// Variables globales que controlan la posición del robot en el mapa
unsigned int posInicial = 180;
unsigned int posActual = posInicial;

Servo motorA;
Servo motorB;



/**
 * #################################
 * # FUNCIONES GENERALES DEL ROBOT #
 * #################################
 * - setup
 * - loop
 * 
*/

void setup() {
  motorA.attach(pinMotorA);
  motorB.attach(pinMotorB);
  DetenerMotores();
  
  Serial.begin(115200);
  
  pinMode(LED_BUILTIN, OUTPUT);
  while (WiFi.status() != WL_CONNECTED) {
    digitalWrite(LED_BUILTIN, LOW);
    delay(250);
    digitalWrite(LED_BUILTIN, HIGH);
    delay(250);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to the WiFi network");
  client.setServer(mqttServer, mqttPort);
  client.setCallback(MQTT_callback);

  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");
    //if (client.connect(clientID, mqttUser, mqttPassword )) {
    if (client.connect(clientID)) {
      Serial.println("connected");
      digitalWrite(LED_BUILTIN, LOW);
      
    } else {
      Serial.println("failed with state ");
      Serial.println(client.state());
      delay(2000);
    }

  }

  //Opcionales
  client.subscribe(topicArduino);
  client.publish(topicWebApp, "KROTIC Arduino suscrito a itcr/lutec/krotic/Arduino");
  client.publish(topicCircuitoEsperanza, "KROTIC Arduino suscrito a itcr/lutec/krotic/arduino");
}


void loop() {
  if (!client.connected()) {
    digitalWrite(LED_BUILTIN, HIGH);
    reconnect();
  }
  client.loop();
  delay(500);
}

//print any message received for subscribed topic
void MQTT_callback(char* topic, byte* payload, unsigned int length) {
  String rawjson = (char*) payload;
  DynamicJsonDocument doc(1024);
  DeserializationError error = deserializeJson(doc, rawjson);
  if (error) {
    Serial.println(error.c_str());
    return;
  }
  JsonArray code = doc["code"].as<JsonArray>();
  if(!code.isNull()){
    client.publish(topicWebApp,"{\"inicio\": \"programa demo\"}");
    Serial.println("Inicio");
    Ejecutar(code);
    Serial.println("Fin");
    client.publish(topicWebApp,"{\"fin\": \"programa demo\"}");
  }
  
  else {
    Serial.println("{\"Error\":\"Sin codigo\"}");
  }
}



void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect(clientID)) { 
      Serial.println("connected");
      client.subscribe(topicArduino);
      digitalWrite(LED_BUILTIN, LOW);
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void ClearSerial(){ while(Serial.available()) { Serial.read(); } }



void Ejecutar(JsonArray code){
  for(JsonVariant elem : code){
    if(elem.is<int>()){
      int id = elem.as<int>();
      EjecutarAux(id);    
      String strId = "cmd:" + String(id);
      Serial.println(strId);
      client.publish(topicWebApp, strId.c_str());             
    }
    else if(elem.is<JsonObject>())
    { 
      JsonObject control = elem;
      int cmdID= control["id"]; 
      switch (cmdID) {
        case 3:
          Mientras(control);
          break;
      }  
    }
    else{
      Serial.println("Error with control line");
    }
  }
}



void EjecutarAux(int cmdID){
  Blink(1);
  switch (cmdID) {
    case 1:
      Blink(1);
      break;
    case 2:
      Blink(2);
      break;
    case 3:
      break;
    case 101:
      Serial.println("Avanza 30cm");
      Avanzar30();
      break;
    case 102:
      Retroceder10();
      break;
    case 103:
      Girar(posActual+90);
      break;
    case 104:
      Girar(posActual+45);
      break;
    default:
      Blink(3);
      break;
  }
}

void Mientras(JsonObject mientras ){
  if(mientras["cond"].as<int>() == 6){
    int veces = mientras["param"].as<int>();
    for(int i = 0; i < veces; i++){
      JsonArray code = mientras["bloque"].as<JsonArray>();
      if(!code.isNull()){
        Ejecutar(code);
      }
    }
  }
}




/**
 * ###################################################
 * # FUNCIONES PARA CONTROL DEL MOVIMIENTO DEL ROBOT #
 * ####################################################
 * - DetenerMotores
 * - Avanzar30
 * - Retroceder10
 * - Girar
 */


//Detiene los motores.
void DetenerMotores() {
  motorA.write(VEL0_A);
  motorB.write(VEL0_B);
}

void Avanzar30() {
  motorA.write(0);
  motorB.write(180);
  delay(TIEMPO_AVANZAR_30);
  DetenerMotores();
}

void Retroceder10() {
  motorA.write(180);
  motorB.write(0);
  delay(500);
  DetenerMotores();
}

void Girar(unsigned int posSiguiente) 
{  
  int diferencia = posSiguiente - posActual;
  bool sentido = false;
  if(diferencia < 0){
    sentido = true;
  }
  diferencia = abs(diferencia);
  if(diferencia > 180){
    sentido = !sentido;
    diferencia = 360 - diferencia; 
  }
  
  if (sentido) {
    motorA.write(0);
    motorB.write(0);
  }
  else {
    motorA.write(180);
    motorB.write(180);
  }
  switch (diferencia) {
    case 45:
      delay(TIEMPO_ROTAR_45);
      break;
    case 90:
      delay(TIEMPO_ROTAR_90);
      break;
    case 135:
      delay(TIEMPO_ROTAR_135);
      break;
    case 180:
      delay(TIEMPO_ROTAR_180);
      break; 
  }
  DetenerMotores();
  posActual = posSiguiente;
}


/**
 * ###################################################
 * # FUNCIONES PARA INDICAR EJECUCION DE UN PROGRAMA #
 * ###################################################
 * - Parpadeo/blink
 * - ParpadeoInicio
 * - BtnEspera
 */

void Blink(unsigned int blinks) {
  for (int i = blinks; i >= 1; i--) {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(100);
    digitalWrite(LED_BUILTIN, LOW);
    delay(100);
  }
}
