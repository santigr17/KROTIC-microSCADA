import 'package:remotekrotic_app/pages/instruccion_page.dart';

import 'instruccion.dart';

class Modulo {
  bool selecionado = false;
  int idModulo;
  String nombre;
  String descripcion;
  List<Instruccion> comandos;

  Modulo(this.idModulo, this.descripcion, this.nombre);
  
  Modulo.fromJson(Map<String, dynamic> json)
  {
    this.nombre = json['nombre'];
    this.idModulo = json['idModulo'];
    this.descripcion = json['descripcion'];
    this.comandos = [];
    if(json['instrucciones'] != null) {
      json['instrucciones'].forEach((value){
        comandos.add(new Instruccion.fromJson(value));
      });
    }
  } 
  void seleccionar(bool check) {
    this.selecionado = check;
  }  
}