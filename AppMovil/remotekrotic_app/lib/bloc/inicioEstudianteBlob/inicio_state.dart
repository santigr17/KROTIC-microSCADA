import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class InicioState extends Equatable {
  List<Object> get props => [];
}

class Inicial extends InicioState {}

class EsperandoDatos extends InicioState {}
class ListaVacia extends InicioState {}
class ConfirmarSalida extends InicioState{}
class EstudiantesListos extends InicioState {
  final List<Estudiante> estudiantes;
  EstudiantesListos(this.estudiantes);
}
class ListaProgramas extends InicioState {
  final List<Programa> programas;
  ListaProgramas(this.programas);
}

class AbriendoEditor extends InicioState {}

