import 'instruccion.dart';

class Modulo {
  final int _idModulo;
  final String _nombre;
  final List<Instruccion> _instrucciones;
  final String _descripcion;
  bool _selecionado = false;

  Modulo(this._idModulo, this._instrucciones, this._descripcion, this._nombre);

  String get nombre => _nombre;
    
  Modulo equipar() {
    this._selecionado = true;
  }  
  Modulo quitar() {
    this._selecionado = false;
  }  
}