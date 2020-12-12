import 'package:remotekrotic_app/models/modulo.dart';

import 'instruccion.dart';

class Programa {
  int idprograma;
  String nombrePrograma;
  String fecha;
  String estado;
  List<Modulo> robot;
  List<dynamic> instrucciones;
  // Variables para controlar los ciclos
  int ciclos = 0;
  bool finalizado = false;
  Programa({
    this.idprograma,
    this.nombrePrograma,
    this.fecha,
    this.estado,
    this.robot,
    this.instrucciones,
  });

  Programa.fromJson(Map<String, dynamic> jsonProg);
  
  Programa.resumefromJson(jsonProg){
    this.idprograma = jsonProg['id'];
    this.nombrePrograma = jsonProg['nombre'];
    this.fecha = jsonProg['fecha'];
    this.estado = jsonProg['estado'];
  }
}
