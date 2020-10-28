import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class Inicio extends StatelessWidget {
  final Usuario user;
  const Inicio({Key key, this.user}) : super(key: key);
}

class InicioEncargado extends Inicio {
  InicioEncargado({Key key, Usuario encargado}) : super(key: key, user: encargado);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class InicioEstudiante extends Inicio {
  InicioEstudiante({Key key, Usuario estudiante}) : super(key: key, user: estudiante);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Bienvenido Estudiante!"),);
  }
  
}