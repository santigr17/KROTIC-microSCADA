import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/views/robotView.dart';

class ProgramView extends StatefulWidget {
  ProgramView({Key key}) : super(key: key);

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  final List<Modulo> robot = null;
  final bool equipando = false;

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
        if(equipando)
         Text("PROGRAMANDO"),
        if(!equipando)
          Expanded(child: RobotView()),
        ],)
    );
  }
}