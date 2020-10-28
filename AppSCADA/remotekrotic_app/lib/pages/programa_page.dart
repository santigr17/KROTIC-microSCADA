import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/robotBloc/moduloBloc.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/pages/robot_page.dart';

class VistaPrograma extends StatefulWidget {
  final Estudiante user;
  VistaPrograma({Key key, this.user}) : super(key: key);

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<VistaPrograma> {
  final List<Modulo> robot = null;
  final bool equipando = true;
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Scaffold(
      appBar: AppBar(title: Text("KROTIC-microSCADA"),),
      body: Column(
        children: <Widget>[
          if(equipando == true)
            Expanded(
              child: BlocProvider(
                create: (context) => ModuloBloc(storage: []),
                child: RobotView(),
              )
            )
        ],)
    );
  }
}