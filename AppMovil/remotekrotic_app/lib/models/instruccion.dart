class Instruccion {
  String _idInstruccion;
  String nombre;
  String descripcion;
  String _tipo;
  Instruccion.fromJson(Map<String, dynamic> json){
    this._idInstruccion = json["idInstruccion"];
    this.descripcion = json["descripcion"];
    this.nombre = json["nombre"];
    this._tipo = json["tipo"];
  }
}

class Mientras extends Instruccion {
  Instruccion condicion;
  List<Instruccion> bloque;
  Mientras.fromJson(instru) : super.fromJson(instru);
}