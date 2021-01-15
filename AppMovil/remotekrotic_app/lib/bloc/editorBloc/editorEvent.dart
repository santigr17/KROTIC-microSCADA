
import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorBloc.dart';
import 'package:remotekrotic_app/modelos/instruccion.dart';
import 'package:remotekrotic_app/modelos/modulo.dart';

abstract class EditorEvent extends Equatable{}
// final Usuario user;
// InicioEvent(this.user);

class CargarDisponibles extends EditorEvent{
  @override
  List<Object> get props => [];
}

class EditarRobot extends EditorEvent{
  final List<Modulo> robot;
  EditarRobot(this.robot);
  @override
  List<Object> get props => [robot];
}
class EquiparModulo extends EditorEvent{
  final Modulo mod;
  EquiparModulo(this.mod);
  @override
  List<Object> get props => [mod];
}
class DesequiparModulo extends EditorEvent{
  final Modulo mod;
  DesequiparModulo(this.mod);
  @override
  List<Object> get props => [mod];
}

class ProgramarRobot extends EditorEvent{
  final List<Modulo> robot;
  final bool finalizado;
  ProgramarRobot(this.robot, {this.finalizado = false});
  @override
  List<Object> get props => [robot];
}

class EditarNombre extends EditorEvent {
  final String nombre;
  EditarNombre(this.nombre);
  @override
  List<Object> get props => [nombre];
}

class AgregarInstruccion extends EditorEvent{
  final Instruccion newInstruccion;
  AgregarInstruccion(this.newInstruccion);
  @override
  List<Object> get props => [newInstruccion];
}

class AgregarMientras extends EditorEvent{ 
  final Mientras newInstruccion;
  AgregarMientras(this.newInstruccion);
  @override
  List<Object> get props => [newInstruccion];
}
class AgregarCondicion extends EditorEvent{ 
  final Instruccion newInstruccion;
  AgregarCondicion(this.newInstruccion);
  @override
  List<Object> get props => [newInstruccion];
}

class ErrorFaltaCondicion extends EditorEvent{
  ErrorFaltaCondicion();
  @override
  List<Object> get props => [];
}

class MostrarError extends EditorEvent{
  final String error;
  MostrarError(this.error);
  @override
  List<Object> get props => [error];
}

class EnviarPrograma extends EditorEvent {
  @override
  List<Object> get props => [];
}


