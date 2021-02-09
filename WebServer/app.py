import json
from flask_mqtt import Mqtt
from flask_mongoengine import MongoEngine
from flask import Flask, request, jsonify, render_template
# LOCAL FILES
from modelos.programa import Programa
from modelos.usuarios import Usuario


app = Flask(__name__)

app.config['MQTT_BROKER_URL'] = 'broker.hivemq.com'  # use the free broker from HIVEMQ
app.config['MQTT_BROKER_PORT'] = 1883  # default port for non-tls connection
app.config['MQTT_USERNAME'] = ''  # set the username here if you need authentication for the broker
app.config['MQTT_PASSWORD'] = ''  # set the password here if the broker demands authentication
app.config['MQTT_KEEPALIVE'] = 5  # set the time interval for sending a ping to the broker to 5 seconds
app.config['MQTT_TLS_ENABLED'] = False  # set TLS to disabled for testing purposes

mqtt = Mqtt(app)

app.config['MONGODB_SETTINGS'] = {
    'db': 'krotic-db',
    'host': '127.0.0.1',
    'port': 27017
}
db = MongoEngine()
db.init_app(app)

# MQTT topics for subscribing and publishing
topicArduino = 'itcr/lutec/krotic/Arduino'
topicCircuitoEsperanza = 'itcr/lutec/krotic/CircuitoEsperanza'
topicWebApp = 'itcr/lutec/krotic/WebApp'

## ARCHIVOS CONFIG

modulosDisponibles = []
instruccionesDisponibles = []
try:
    with open("recursos/modulos.json") as jsonFile:
        jsonModulos = json.load(jsonFile)
        modulosDisponibles = jsonModulos['modulos']
        
    with open("recursos/instrucciones.json") as jsonFile:
        jsonInstrucciones = json.load(jsonFile)
        instruccionesDisponibles = jsonInstrucciones['instrucciones']
        
    for modulo in modulosDisponibles:
        for instruXmodulo in modulo['instrucciones']:
            instruccionesDisponibles.append(instruXmodulo)
    print(" - Modulos e Instrucciones cargados correctamente.")

except Exception as e:
    print(e)
    print("ERROR: NO SE PUDIERON CARGAR ARCHIVOS DE INSTRUCCIONES Y MÓDULOS")
    

@mqtt.on_connect()
def handle_connect(client, userdata, flags, rc):
    mqtt.subscribe(topicWebApp)
    print(" - Subscripción MQTT a: " + topicWebApp)

@mqtt.on_message()
def handle_mqtt_message(client, userdata, message):
    # print("new data")
    data = dict(
        topic=message.topic,
        payload=message.payload.decode()
    )
    print("DATA:",data["payload"])


@app.route('/', methods=['GET'])
def index():
    return render_template('index.html',programas=[])


@app.route('/programa/ejecutar', methods=['GET'])
def ejecutar():
    prograId = request.args.get('id')
    progra = Programa.objects(idPrograma = prograId).first()
    print(type(progra.to_json()))
    prograJson = progra.to_json()
    # mqtt.publish(topicCircuitoEsperanza, prograJson)
    return jsonify({"Executing":progra})


@app.route('/programa/ejecutar/demo', methods=['GET'])
def ejecutar_demo():
    prograJson = "{\"code\":[1, 101, 103, 101, {\"id\":3,\"cond\":6,\"param\":2,\"bloque\":[101,103,102,104]},2]}"
    mqtt.publish(topicArduino, prograJson)
    return prograJson

@app.route('/programa/grabar', methods=['GET'])
def grabar_programa():
    grabando = request.args.get('grabando',type=int)
    cmd = "{\"cmd\":\"Grabar\"}"
    if(grabando == 0):
        cmd = "{\"cmd\":\"Detener\"}"

    mqtt.publish(topicCircuitoEsperanza, cmd)
    return jsonify({"Enviado: ":cmd})

@app.route('/programa/subirvideos', methods=['GET'])
def subir_videos():
    cmd = "{\"cmd\":\"Subir\"}"
    mqtt.publish(topicCircuitoEsperanza, cmd)
    return jsonify({"Enviado: ":cmd})



@app.route('/programa/ejecutar/Arduino/demo', methods=['GET'])
def Arduino_demo():
    prograJson = "{\"code\":[1,{\"id\":3,\"cond\":6,\"param\":2,\"bloque\":[101,103,117]},2]}"
    mqtt.publish(topicArduino, prograJson)
    return prograJson


@app.route('/mqtt/hola_mundo', methods=['GET'])
def hola_mundo_mqtt():
    mqtt.publish('krotic', 'cancel')
    return jsonify({"hola mundo":"mqtt"})

@app.route('/mqtt/hola_pista', methods=['GET'])
def hola_pista_mqtt():
    mqtt.publish('krotic/circuito_esperanza', 'hola mundo mqtt circuito')
    return jsonify({"hola mundo circuito":"mqtt"})

@app.route('/programas', methods=['GET'])
def query_programas():
    progras = Programa.objects().all()
    item = request.args.get('id')
    vista = {}
    if(item):
        progra = Programa.objects(idPrograma = item).first()        
        user = Usuario.objects(idUsuario = progra.idUsuario).first()
        vista["usuario"] = user
        vista["programa"] = progra
        mods = []
        inst = []
        for modulo in modulosDisponibles:
            if(modulo['idModulo'] in progra.modulos):
                mods.append(modulo)
        
        vista["modulos"] = mods
    # print(vista)
    return render_template("programas.html",programas = progras, vista = vista)
   


@app.route('/app/programas', methods=['GET'])
def query_programas_usuario():
    userId = request.args.get('idusuario')
    progras = Programa.objects(idUsuario = userId)
    return jsonify(progras.to_json())



@app.route('/programa/', methods=['POST'])
def crear_programa():
    dataPrograma = json.loads(request.data)
    newProgra = Programa.fromJson(dataPrograma)
    if(newProgra == None):
        return jsonify({'error': 'Error en formato'})
    try:
        print("Guardando programa ........")
        newProgra.save()
        print("Programa salvado correctamente")
        return jsonify(newProgra)
    except Exception as e:
        print(dataPrograma)
        print(newProgra)
        
        print(e)
        return jsonify({'error': 'Error salvando el programa'})

@app.route('/usuarios/registrar', methods=['POST'])
def registrar_usuario():
    dataUser = json.loads(request.data)
    newUser = Usuario.fromJson(dataUser)
    if(newUser == None):
        return jsonify({'error': 'Error en formato'})
    try:
        print("Creando usuario ........")
        newUser.save()
        print("Usuario creado correctamente")
        return jsonify(newUser)
    except Exception as e:
        print(dataUser)
        print(newUser)
        print(e)
        return jsonify({'error': 'Error salvando el usuario'})




if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)

#################################################################
#                                                               #
#################################################################

# class User(db.Document):
#     name = db.StringField()
#     email = db.StringField()
#     def to_json(self):
#         return {"name": self.name,
#                 "email": self.email}

# @app.route('/usuario', methods=['GET'])
# def query_records():
#     name = request.args.get('name')
#     user = User.objects(name=name).first()
#     if not user:
#         return jsonify({'error': 'data not found'})
#     else:
#         return jsonify(user.to_json())

# @app.route('/', methods=['POST'])
# def create_record():
#     record = json.loads(request.data)
#     user = User(name=record['name'],
#                 email=record['email'])
#     user.save()
#     return jsonify(user.to_json())

# @app.route('/', methods=['PUT'])
# def update_record():
#     record = json.loads(request.data)
#     user = User.objects(name=record['name']).first()
#     if not user:
#         return jsonify({'error': 'data not found'})
#     else:
#         user.update(email=record['email'])
#     return jsonify(user.to_json())

# @app.route('/', methods=['DELETE'])
# def delete_record():
#     record = json.loads(request.data)
#     user = User.objects(name=record['name']).first()
#     if not user:
#         return jsonify({'error': 'data not found'})
#     else:
#         user.delete()
#     return jsonify(user.to_json())

