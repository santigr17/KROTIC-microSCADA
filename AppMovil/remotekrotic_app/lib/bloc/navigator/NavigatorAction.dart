import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:remotekrotic_app/modelos/usuarios_model.dart';

abstract class NavigatorAction extends Equatable{}
class NavigatorActionPop extends NavigatorAction{
  @override
  List<Object> get props => [];
}

class NavegarInicioEstudiante extends NavigatorAction {
  final Usuario estudiante;

  NavegarInicioEstudiante({
    @required this.estudiante,
  });
  @override
  List<Object> get props => [];
}

class NavegarEditor extends NavigatorAction {
  final Estudiante estudiante;

  NavegarEditor(this.estudiante);
  @override
  List<Object> get props => [];

}