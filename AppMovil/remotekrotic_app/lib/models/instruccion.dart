/**
 * Constantes para comparaciones
 */
const String mientrasID = "iks03";
const String finID = "iks05";

class Instruccion {
  final String idInstruccion;
  final String nombre;
  final String descripcion;
  final String tipo;
  int anidado = 0;
  Instruccion({this.idInstruccion, this.nombre, this.descripcion, this.tipo});
  factory Instruccion.fromJson(Map<String, dynamic> json){
    return Instruccion(
    idInstruccion : json["idInstruccion"],
    descripcion : json["descripcion"],
    nombre : json["nombre"],
    tipo : json["tipo"]
    );
  }
  factory Instruccion.clone(Instruccion template){
    return Instruccion(
      nombre: template.nombre,
      idInstruccion: template.idInstruccion,
      tipo: template.tipo,
      descripcion: template.descripcion
    );
  }
}

class Condicion extends Instruccion {
  Condicion({String idInstruccion, String nombre, String descripcion,  String tipo}):super(idInstruccion: idInstruccion, nombre: nombre, descripcion: descripcion, tipo: tipo);
  factory Condicion.fromJson(Map<String, dynamic> json){
    return Condicion(
      idInstruccion : json["idInstruccion"],
      descripcion : json["descripcion"],
      nombre : json["nombre"],
      tipo : json["tipo"]
    );
  }
  factory Condicion.clone(Mientras template){
    return Condicion(
      nombre: template.nombre,
      idInstruccion: template.idInstruccion,
      tipo: template.tipo,
      descripcion: template.descripcion
    );
  }
}

class Mientras extends Instruccion {
  Instruccion condicion;
  List<dynamic> bloque = [];
  Mientras({String idInstruccion, String nombre, String descripcion,  String tipo, this.condicion, this.bloque}):super(idInstruccion: idInstruccion, nombre: nombre, descripcion: descripcion, tipo: tipo);
  factory Mientras.fromJson(Map<String, dynamic> json){
    return Mientras(
      idInstruccion : json["idInstruccion"],
      descripcion : json["descripcion"],
      nombre : json["nombre"],
      tipo : json["tipo"]
    );
  }
  factory Mientras.clone(Mientras template){
    return Mientras(
      bloque: template.bloque,
      condicion: template.condicion,
      nombre: template.nombre,
      idInstruccion: template.idInstruccion,
      tipo: template.tipo,
      descripcion: template.descripcion
    );
  }
}