import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:remotekrotic_app/models/programa.dart';

abstract class InicioState extends Equatable {
  List<Object> get props => [];
}

class LoginInitial extends InicioState {}

// Cargando programas
class LoadingProgramas extends InicioState {}

// Los programas son cargados desde el almacenamiento 
class ListedProgramas extends InicioState {
  final List<Programa> list;
  ListedProgramas({@required this.list});

  @override
  List<Object> get props => [list];  

}
