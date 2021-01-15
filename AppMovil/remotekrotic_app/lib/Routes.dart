import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remotekrotic_app/modelos/usuarios_model.dart';
import 'package:remotekrotic_app/pages/editor_page.dart';
import 'package:remotekrotic_app/pages/inicio_page.dart';
import 'package:remotekrotic_app/pages/login_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());

      case '/inicio_estudiante':
        if(settings.arguments is Usuario){
          return MaterialPageRoute(builder: (_) => InicioEstudiante(estudiante: settings.arguments,));
        }
        else{
          print("Settings argument was undifined");
          return MaterialPageRoute(builder: (_) => showError(settings.name));
        }
        break;

      case '/editor':
        return MaterialPageRoute(builder: (_) => EditorPrograma(user: settings.arguments,));

      default:
        showError(settings.name);
        break;
    }
  }
}

Widget showError (String error) {
  return Scaffold(
      body: Center(
        child: Text('No route defined for $error')));
}