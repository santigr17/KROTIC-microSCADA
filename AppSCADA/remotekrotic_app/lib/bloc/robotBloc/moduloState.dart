import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:remotekrotic_app/models/modulo.dart';

abstract class ModuloState extends Equatable { }

class ModuloInitialState extends ModuloState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ModuloLoadingState extends ModuloState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ModuloLoadedState extends ModuloState {
  List<Modulo> modulos;
  ModuloLoadedState({@required this.modulos});
  @override
  // TODO: implement props
  List<Object> get props => [modulos];
}

class ModuloErrorState extends ModuloState {
  String mns;
  ModuloErrorState({@required this.mns});

  @override
  // TODO: implement props
  List<Object> get props => [mns];
}