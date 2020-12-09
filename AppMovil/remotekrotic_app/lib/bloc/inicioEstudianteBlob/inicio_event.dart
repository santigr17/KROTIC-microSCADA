import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class InicioEvent extends Equatable {
  final Usuario user;
  InicioEvent(this.user);
}

///Eventos generales para ambos usuarios
class CargarDatos extends InicioEvent{
  CargarDatos(Usuario user) : super(user);
  @override
  List<Object> get props => [];
  
}
/// Eventos relacionados con el niño 
class ProgramasCargados extends InicioEvent {
  final List<Programa> lista;
  ProgramasCargados({@required this.lista,@required user}) : super(user);
  
  @override
  List<Object> get props => [lista];  
}
class EstudiantesCargados extends InicioEvent {
  final List<Programa> lista;
  EstudiantesCargados({@required this.lista,@required user}) : super(user);
  
  @override
  List<Object> get props => [lista];  
}
class CrearProgra extends InicioEvent {
  CrearProgra(Usuario user) : super(user);
  @override
  List<Object> get props => [];
}

class EnviarPrograma extends InicioEvent {
  final Programa _seleccion;

  EnviarPrograma(Programa seleccion, Usuario user) : 
    this._seleccion = seleccion,
    super(user);

  @override
  List<Object> get props => [ _seleccion, user];
}
