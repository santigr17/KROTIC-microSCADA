"""
Ejemplo de como utilizar la clase ControladorCamara.
La clase hereda de la clase Thread de python para el manejo de hilos
Crea un 
"""
import ControladorCamara as CC
import time

controlador1 = CC.ControladorCamara(0, 'Cam0')
controlador2 = CC.ControladorCamara(2, 'Cam2')
controlador3 = CC.ControladorCamara(4, 'Cam4')

controlador1.start()
controlador2.start()
controlador3.start()


time.sleep(1)
input("Presione Enter para terminar\n")
if(controlador1.status):
    controlador1.grabando = False
if(controlador2.status):
    controlador2.grabando = False
if(controlador3.status):
    controlador3.grabando = False
