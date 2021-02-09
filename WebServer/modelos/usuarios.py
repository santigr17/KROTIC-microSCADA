from flask_mongoengine import MongoEngine
from datetime import datetime

db = MongoEngine()
class Usuario (db.Document):
    idUsuario = db.IntField(required = True, unique = True)
    nombre = db.StringField(required = True)
    username = db.StringField(required = True, unique = True)
    password = db.StringField(required = True)
    
    def fromJson(jsonFile):
        nuevoUsuario = None
        try:
            nuevoUsuario = Usuario(
                idUsuario = jsonFile['idUsuario'],
                nombre = jsonFile['nombre'],
                username = jsonFile['username'],
                password = jsonFile['password']
            )
        except Exception as e:
            print(e)
            print("Error en el formato del Json del usuario nuevo")
        
        return nuevoUsuario
        