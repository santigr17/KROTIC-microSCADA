import ControladorCamara as CC
import time

PATH_PROGRAMA = "recursos/programaTemp.json"
PATH_GRABACIONES = "Grabaciones/"

class CircuitoEsperanza:
    def __init__(self):
        self.idCircuito = "Esperanza"
        self.tInicial = 0
        self.grabando = False
        self.camaras = []
        
    def checkCamaras(self):
        status = []
        for cam in self.camaras:
            if( not cam.status ):
                status.append(cam.idCam)
        return status

    def iniciarGrabacion(self):
        controlador1 = CC.ControladorCamara(0, 'Cam0', path=PATH_GRABACIONES)
        controlador3 = CC.ControladorCamara(2, 'Cam2', path=PATH_GRABACIONES)
        controlador2 = CC.ControladorCamara(4, 'Cam4', path=PATH_GRABACIONES)
        self.camaras = [controlador1, controlador2, controlador3]
        time.sleep(1)
        for cam in self.camaras:
            if(not cam.status):
                self.camaras.remove(cam)
                print("Cámara con ID {} no se pudo inicializar".format(cam.idCam))
        while(len(self.camaras) < 3):
            newID = input("\nIngrese un nuevo ID\n(int): ")
            camTemp = CC.ControladorCamara(int(newID), 'Cam'+newID, path=PATH_GRABACIONES)
            if(camTemp.status):
                self.camaras.append(camTemp)
            else:
                print("Cámara con ID {} no se pudo inicializar".format(newID))
        for cam in self.camaras:
            cam.start()
            print("Camara {} iniciada".format(cam.idCam))

        print("Iniciando grabación")
        for cam in self.camaras:
            if(cam.status):
                cam.grabando = True
        self.tInicial = time.time()
        self.grabando = True

    def detenerGrabacion(self):
        if(self.grabando):
            self.grabando = False
            intervalo = time.time() - self.tInicial
            print("Finalizando grabación.\n  Duración: {}".format(intervalo))
            for cam in self.camaras:
                if(cam.status):
                    cam.grabando = False
                    print("  Cam ID{} grabación detenida".format(cam.idCam))
                    print("  Archivo: {}".format(cam.filename))
        else:
            print("Debe iniciar la grabacion para realizar operación")

        
    def cargarPrograma(self, programaJson):
        self.progra = programaJson
    
    def convertirPrograma(Programa):
        pass
        
    def transferirPrograma(self):
        pass
        


