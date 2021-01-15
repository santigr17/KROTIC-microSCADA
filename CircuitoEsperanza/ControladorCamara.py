import numpy as np
import cv2
import threading
import time

class ControladorCamara (threading.Thread):

    fps = 10
    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    grabando = False
    formato = '.avi'
    status = True

    def __init__(self, idCamara, vista, path = "Grabaciones/",*args):
        threading.Thread.__init__(self)
        self.path = path
        self.idCam = idCamara
        self.filename = self.path + vista + self.formato
        cv2.VideoCapture(idCamara).release()

        print("Inicialización de la cámara")
        self.cam = cv2.VideoCapture(idCamara)
        self.cam.set(cv2.CAP_PROP_FOURCC,cv2.VideoWriter_fourcc('M','J','P','G'))

        if (self.cam is None or not self.cam.isOpened()):
            self.status = False
            print("No se pudo inicializar la cámara con Id:", self.idCam)
        else:
            width = 640 #self.cam.get(cv2.CAP_PROP_FRAME_WIDTH)
            height = 480 #self.cam.get(cv2.CAP_PROP_FRAME_HEIGHT)
            resolucion =  (320, 240) #  (int(width),int(height))
            # resolucion = '640x480'
            self.video = cv2.VideoWriter(self.filename, self.fourcc, self.fps, (width, height))
            print("Archivo configurado: \n  Nombre: {}\n  Resolucion:{}\n  fps:{}".format(self.filename, resolucion, self.fps))
            self.status = True

    def run(self):
        self.grabando = True
        while self.status and self.grabando:
            ret, frame = self.cam.read()
            if(not ret):
                print("Error leyendo un frame.")
                self.status = False
                break

            self.video.write(frame)
        self.video.release()
        self.cam.release()
        cv2.destroyAllWindows()

