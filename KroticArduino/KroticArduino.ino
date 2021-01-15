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
#include <StreamUtils.h>
#include <ArduinoJson.hpp>
#include <ArduinoJson.h>


// Definición de los pines
#define pinMotorA 5
#define pinMotorB 6
#define pinSensorA A1
#define pinSensorB A2
#define ledPinA 10
#define ledPinB 11
#define ledConfig 9
#define btnStart 8


/**
 * #########################################################################
 * # CONSTANTES PARA LA COMUNICACION SERIAL Y EL CONTROL GENERAL DEL ROBOT #
 * #########################################################################
 */
bool  ejecucion = false;


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
    digitalWrite(ledConfig, HIGH);
    delay(100);
    digitalWrite(ledConfig, LOW);
    delay(100);
  }
}


/**
 * Función que espera 3 segundos para ejecutar las instrucciones del robot   
 * después de la indicacion de inicio con el botón.
*/
void ParpadeoInicio() {
  Blink(1);
  delay(1000);   // 1s
  Blink(2);
  delay(500);   // 1.5s
  Blink(3);
}



void BtnEspera() {
  bool wait = 0;
  while (!wait) {
    wait = digitalRead(btnStart); //pin 9
    delay(50);
  }
}


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
  pinMode(ledConfig, OUTPUT);
  digitalWrite(ledConfig, HIGH);
  Serial.begin(115200);
//  Serial.setTimeout(5000);
  ParpadeoInicio();
  Serial.println("Arduino listo");
}


void loop() {
  if(Serial.available()){
    Blink(1);
    while(Serial.available()){
      String inputString = Serial.readStringUntil('\n');
      if(ejecucion){
          int dosPuntos = inputString.indexOf(':');
          if (dosPuntos > 0) {
            String comando = inputString.substring(0, dosPuntos);
            String valor = inputString.substring(dosPuntos + 1, inputString.length());
        
            if (comando == "cmd") {
              Ejecutar(valor.toInt());
              Serial.print("ok:");
              Serial.println(valor);
            }
            else {
              Serial.print("Error ");
              Serial.println(inputString);
            }
          }
          else if(inputString == "fin"){ 
            ejecucion = false;
            Serial.println("ok");
          }
          else if(inputString == "clear"){
            ClearSerial();
            Serial.println("ok");
          }
          else { Serial.println(inputString); }
      }
      else if(inputString == "inicio") {
        ejecucion = true;
        Serial.println("ok");
      }
    }
  }
  
  if(ejecucion){
    Blink(1);
  }
}


void Ejecutar(int cmdID){
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

void ClearSerial(){ while(Serial.available()) { Serial.read(); } }

  
