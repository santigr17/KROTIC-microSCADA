import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/models/programa.dart';

abstract class InicioEvent extends Equatable {
  final Programa selected;
  InicioEvent(this.selected);
  @override
  List<Object> get props => [];
}

class CreatePrograma extends InicioEvent {
  CreatePrograma() : super(null);
}

class SendPrograma extends InicioEvent {
  SendPrograma(Programa selected) : super(selected);
}

class EditPrograma extends InicioEvent {
  EditPrograma(Programa selected) : super(selected);
}

class EditRobot extends InicioEvent {
  EditRobot(Programa selected) : super(selected);
}

class ViewFeedback extends InicioEvent {
  ViewFeedback(Programa selected) : super(selected);
}