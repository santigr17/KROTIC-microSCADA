
import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/modulo.dart';

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
  ProgramarRobot(this.robot);
  @override
  List<Object> get props => [robot];
}

class AgregarInstruccion extends EditorEvent{
  final Instruccion newInstruccion;
  AgregarInstruccion(this.newInstruccion);
  @override
  List<Object> get props => [newInstruccion];
}

class MostrarError extends EditorEvent{
  final String error;
  MostrarError(this.error);
  @override
  List<Object> get props => [error];
}
