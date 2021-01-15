from flask_mongoengine import MongoEngine
from datetime import datetime

db = MongoEngine()
class Programa (db.Document):
    idPrograma = db.IntField(required = True, unique = True)
    idUsuario = db.IntField(required = True)
    nombre = db.StringField(required = True)
    fechaCreacion = db.StringField(required = True)
    fechaRecibido = db.StringField(required = True)
    fechaEjecucion = db.StringField()
    modulos = db.ListField(db.IntField())
    instrucciones = db.ListField(db.IntField())
    
    def fromJson(jsonFile):
        prograNueva = None
        try:
            recibido = datetime.now()
            prograNueva = Programa(
                idPrograma = jsonFile['idPrograma'],
                idUsuario = jsonFile['idUsuario'],
                nombre = jsonFile['nombre'],
                fechaCreacion = jsonFile['fechaCreacion'],
                fechaRecibido = recibido.strftime("%Y/%m/%d, %H:%M:%S"),
                modulos = eval(jsonFile['modulos']),
                instrucciones = eval(jsonFile['instrucciones'])

            )
        except Exception as e:
            print(e)
            print("Error en el formato del Json del programa nuevo")
        
        return prograNueva
        