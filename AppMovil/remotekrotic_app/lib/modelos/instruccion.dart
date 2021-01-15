/**
 * Constantes para comparaciones
 */
const String mientrasCode = "iks03";
const String finCode = "iks05";

class Instruccion {
  final int idInstruccion;
  final String codigo;
  final String nombre;
  final String descripcion;
  final String tipo;
  int anidado = 0;
  Instruccion({this.idInstruccion, this.codigo, this.nombre, this.descripcion, this.tipo});
  factory Instruccion.fromJson(Map<String, dynamic> json){
    return Instruccion(
      idInstruccion : json["idInstruccion"],
      codigo: json["codigo"],
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
      descripcion: template.descripcion,
      codigo: template.codigo
    );
  }
}

class Condicion extends Instruccion {
  // Constructor principal
  Condicion({int idInstruccion, String codigo, String nombre, String descripcion,  String tipo})
  :super(idInstruccion: idInstruccion, nombre: nombre, descripcion: descripcion, tipo: tipo, codigo: codigo);
  
  
  factory Condicion.fromJson(Map<String, dynamic> json){
    return Condicion(
      idInstruccion : json["idInstruccion"],
      codigo: json["codigo"],
      descripcion : json["descripcion"],
      nombre : json["nombre"],
      tipo : json["tipo"]
    );
  }
  factory Condicion.clone(Mientras template){
    return Condicion(
      idInstruccion: template.idInstruccion,
      codigo: template.codigo,
      nombre: template.nombre,
      tipo: template.tipo,
      descripcion: template.descripcion
    );
  }
}

class Mientras extends Instruccion {
  Instruccion condicion;
  List<dynamic> bloque = [];
  
  Mientras({
    int idInstruccion,
    String codigo,
    String nombre, 
    String descripcion, 
    String tipo,
    this.condicion, 
    this.bloque})
    :super(idInstruccion: idInstruccion, nombre: nombre, descripcion: descripcion, tipo: tipo, codigo: codigo);
  
  factory Mientras.fromJson(Map<String, dynamic> json){
    return Mientras(
      idInstruccion : json["idInstruccion"],
      codigo: json["codigo"],
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
      codigo: template.codigo,
      tipo: template.tipo,
      descripcion: template.descripcion
    );
  }
}