import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/pages/inicio_page.dart';

abstract class InicioState extends Equatable {
  List<Object> get props => [];
}

class Inicial extends InicioState {}
class CargandoListaProgramas extends InicioState {}
class ListaVacia extends InicioState {}
class ListaProgras extends InicioState {
  final List<Programa> programas;
  ListaProgras(this.programas);
}

