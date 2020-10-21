import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remotekrotic_app/views/programaView.dart';

class Login extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // const Login({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Container(child:Text("ERROR"));
        }
        if(snapshot.connectionState == ConnectionState.done){
          return ProgramView();
        }
        return Container(child:Text("Cargando"));
      }
    );
  }
}