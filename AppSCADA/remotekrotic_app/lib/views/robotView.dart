import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RobotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Agregue los módulos que va a necesitar para el robot'),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child:ListView(
                    children: [
                      Text("Modulo 1"),
                      Text("Modulo 2"),
                    ],
                  )
                ),
                Flexible(
                  child: Image(image: AssetImage('assets/images/kroticbasic.jpg')), 
                )
              ],
            ),
          )
        ],
      )
    );
  }
}