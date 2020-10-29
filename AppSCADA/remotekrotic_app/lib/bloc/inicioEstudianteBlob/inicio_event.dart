import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class InicioEvent extends Equatable {
  final Usuario user;
  InicioEvent(this.user);
}

class CargarProgras extends InicioEvent {
  CargarProgras(Usuario user) : super(user);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PrograsCargadas extends InicioEvent {
  final List<Programa> lista;
  PrograsCargadas({@required this.lista,@required user}) : super(user);
  
  @override
  List<Object> get props => [lista];  
}

class CrearProgra extends InicioEvent {
  CrearProgra(Usuario user) : super(user);
  @override
  List<Object> get props => [];
}

class EnviarProgra extends InicioEvent {
  final Programa _seleccion;

  EnviarProgra(Programa seleccion, Usuario user) : 
    this._seleccion = seleccion,
    super(user);

  @override
  List<Object> get props => [ _seleccion, user];
}
