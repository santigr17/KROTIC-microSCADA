class Retroalimentacion:
    def __init__(self, )
class Programa:
    def __init__(self, prograID, userID, nombre, estado, fechaCreacion, fechaRecibido, fechaEjecucion, modulos, instrucciones):
        idPrograma = db.IntField(required = True, unique = True)
        idUsuario = db.IntField(required = True)
        nombre = db.StringField(required = True)
        estado = db.StringField(required = True)
        fechaCreacion = db.StringField(required = True)
        fechaRecibido = db.StringField(required = True)
        fechaEjecucion = db.StringField()
        modulos = db.ListField(db.IntField())
        instrucciones = db.ListField(db.IntField())