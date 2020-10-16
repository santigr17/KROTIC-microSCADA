import cv2
import threading
import numpy as np
import os
import time

activeView = 0
class vista (threading.Thread):
    """
    Clase encargada de manejar una cámara.
    """
    def __init__ (self, camID, nombre, ruta):
        threading.Thread.__init__(self)
        self.previewName = previewName
        self.camID = camID
        self.recording = False
        self.active = False

    def run(self):
        cap = cv2.VideoCapture(0)
        out = cv2.VideoWriter(filename, get_video_type(filename), 25, get_dims(cap, res))

