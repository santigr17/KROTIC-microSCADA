import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remotekrotic_app/models/instruccion.dart';

class InstruccionItem extends StatelessWidget {
  final Instruccion item;

  const InstruccionItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue[100],
          child: Center(
            child: Text(
              this.item.descripcion
            ),
          ),
        ),
        Icon(Icons.arrow_downward_sharp)
      ],
    ); 
  }
}