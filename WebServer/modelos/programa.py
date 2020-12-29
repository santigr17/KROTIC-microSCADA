class Programa:
    def __init__(self, nombre, usuario):
        self.nombre = nombre
        self.idPrograma = nombre+usuario 
        self.usuario = usuario
        self.fecha = "14/12/2020"
        self.intrucciones = []
    
    def fromJson(self, jsonFile):
        
