from flask_mongoengine import MongoEngine
from datetime import datetime

db = MongoEngine()
class Programa (db.Document):
    idPrograma = db.IntField(required = True)
    idUsuario = db.IntField(required = True)
    nombre = db.StringField(required = True)
    estado = db.StringField(required = True)
    fechaCreacion = db.StringField(required = True)
    fechaRecibido = db.StringField(required = True)
    fechaEjecucion = db.StringField()
    modulos = db.ListField(db.IntField())
    instrucciones = db.ListField(db.StringField())
    meta = {
        "auto_create_index": False,
        "index_background": True,
        "indexes": [
            {'fields': ['-idPrograma', '-idUsuario'], 'unique': True }
        ]
    }
    def fromJson(jsonFile):
        prograNueva = None
        try:
            recibido = datetime.now()
            listaMods = jsonFile['modulos']
            listaInst = []
            userID = jsonFile['idUsuario']
            prograID =jsonFile['idPrograma']
            if(isinstance(listaMods,str)):
                listaMods = eval(listaMods)
            for item in jsonFile['instrucciones']:
                listaInst.append(str(item))
            
            if( prograID < 0):
                prograID = Programa.objects().count()
                
            prograNueva = Programa(
                idPrograma = prograID,
                idUsuario = userID,
                nombre = jsonFile['nombre'],
                estado = jsonFile['estado'],
                fechaCreacion = jsonFile['fechaCreacion'],
                fechaRecibido = recibido.strftime("%Y/%m/%d, %H:%M:%S"),
                modulos = listaMods,
                instrucciones = listaInst
            )
        except Exception as e:
            print(e)
            print("Error en el formato del Json del nuevo programa")
        
        return prograNueva
        