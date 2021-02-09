import ControladorCamara as CC
import time
import RPi.GPIO as GPIO
import pyrebase

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
}

firebase = pyrebase.initialize_app(firebaseConfig)
storage = firebase.storage()


PATH_PROGRAMA = "recursos/programaTemp.json"
PATH_GRABACIONES = "Grabaciones/"

path_on_cloud1 = "mock_user/retroalimentacion/Cam0.avi"
path_on_cloud2 = "mock_user/retroalimentacion/Cam2.avi"
path_on_cloud3 = "mock_user/retroalimentacion/Cam4.avi"

path_local1 = "Grabaciones/Cam0.avi"
path_local2 = "Grabaciones/Cam2.avi"
path_local3 = "Grabaciones/Cam4.avi"


#____ pine GPIO basados en BCM _____#
ledsDer = [11,7,5]
ledsIzq = [6,13,19,26]
class CircuitoEsperanza:
    def __init__(self):
        self.idCircuito = "Esperanza"
        self.tInicial = 0
        self.grabando = False
        self.camaras = []
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(ledsIzq, GPIO.OUT)
        GPIO.setup(ledsDer, GPIO.OUT)
        GPIO.output(ledsIzq, 1)
        
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
    
    def publicarVideos(self):
        vid1 = storage.child(path_on_cloud1).put(path_local1)
        vid2 = storage.child(path_on_cloud2).put(path_local2)
        vid3 = storage.child(path_on_cloud3).put(path_local3)

        vidLink1 = storage.child(path_on_cloud1).get_url(vid1['downloadTokens'])
        vidLink2 = storage.child(path_on_cloud2).get_url(vid2['downloadTokens'])
        vidLink3 = storage.child(path_on_cloud3).get_url(vid3['downloadTokens'])
        links = [vidLink1,vidLink2, vidLink3]
        print(links)
        return links

    def convertirPrograma(Programa):
        pass
        
    def transferirPrograma(self):
        pass
        


