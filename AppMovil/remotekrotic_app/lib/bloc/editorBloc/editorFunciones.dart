import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/modulo.dart';

List<Instruccion> comandosSelecc(List<Modulo> modulos) {
  List<Instruccion> temp = [];
  modulos.forEach((element) { 
    if(element.comandos != null && element.selecionado){
      element.comandos.forEach((instruccion) {
        temp.add(instruccion);
      });
    }
  });
  return temp;
}