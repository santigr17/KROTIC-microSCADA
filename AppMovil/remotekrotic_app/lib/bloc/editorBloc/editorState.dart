import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/modelos/instruccion.dart';
import 'package:remotekrotic_app/modelos/modulo.dart';
import 'package:remotekrotic_app/modelos/programa.dart';

abstract class EditorState extends Equatable {
  List<Object> get props => [];
}

class Inicial extends EditorState {}

class Cargando extends EditorState {}

class ErrorRobot extends EditorState {
  final String msgError;
  ErrorRobot(this.msgError);
}

class Equipando extends EditorState
{
  final List<Modulo> robot;
  final List<Modulo> equipos;
  Equipando(this.equipos, this.robot);
}

class Programando extends EditorState 
{
  final List<Instruccion> disponibles;
  final List<dynamic> codigo;
  final Programa prograActual;
  Programando(this.disponibles, this.prograActual, this.codigo);
}
