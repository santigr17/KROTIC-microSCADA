import 'dart:convert';
import 'package:remotekrotic_app/modelos/modulo.dart';

class Programa {
  int idprograma;
  String nombrePrograma;
  String fechaCreacion;
  String estado;
  List<Modulo> robot;
  List<dynamic> instrucciones;
  // Variables para controlar los ciclos
  int ciclos = 0;
  bool finalizado = false;
  Programa({
    this.idprograma,
    this.nombrePrograma,
    this.fechaCreacion,
    this.estado = 'Editado',
    this.robot,
    this.instrucciones,
  });

  Programa.fromJson(Map<String, dynamic> jsonProg);
  
  Programa.resumefromJson(jsonProg){
    this.idprograma = jsonProg['id'];
    this.nombrePrograma = jsonProg['nombre'];
    this.fechaCreacion = jsonProg['fechaCreacion'];
    this.estado = jsonProg['estado'];
  }
  List<int> listaModulosID(){
    List<int> ids = [];
    robot.forEach((item) => ids.add(item.idModulo));
    return ids;
  }
  List<int> listaInstruccionesID(){
    List<int> ids = [];
    instrucciones.forEach((item) => ids.add(item.idInstruccion));
    return ids;
  }

  Map<String, dynamic> toJson(int idUsuario) => {
    'idUsuario' : idUsuario,
    'idPrograma' : idprograma,
    'nombre':nombrePrograma,
    'fechaCreacion':fechaCreacion,
    'estado':estado,
    'modulos':jsonEncode(this.listaModulosID()),
    'instrucciones':jsonEncode(this.listaInstruccionesID())
  };
}
