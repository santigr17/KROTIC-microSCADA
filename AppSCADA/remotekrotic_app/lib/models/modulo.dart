import 'instruccion.dart';

class Modulo {
  bool _selecionado = false;
  int _idModulo;
  String _nombre;
  String _descripcion;
  List<Instruccion> _instruccionesDisponibles;

  Modulo(this._idModulo, this._descripcion, this._nombre);
  Modulo.fromJson(Map<String, dynamic> json)
  {
    this._nombre = json['nombre'];
    this._idModulo = json['idModulo'];
    this._descripcion = json['descripcion'];
  }

  bool get check => _selecionado;
  int get idModulo => _idModulo;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  List<Instruccion> get disponibles => _instruccionesDisponibles;
  
  
  void seleccionar(bool check) {
    this._selecionado = check;
  }  
}