import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/models/programa.dart';

class LocalStorage {

  Future<List<Modulo>> getModules() async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    var strJson = await rootBundle.loadString("assets/data/modules.json");
    var data = json.decode(strJson);
    List<Modulo> modulosDisponibles = new List<Modulo>();
    if(data['modulos'] != null) {
      data['modulos'].forEach((value){
        modulosDisponibles.add(new Modulo.fromJson(value));
      });
    }
    return modulosDisponibles;
  }

  Future<List<Programa>> getListProgramas(id) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    var strJson = await rootBundle.loadString('assets/data/test_user.json');
    var data = json.decode(strJson);
    List<Programa> resumenProgramas = new List<Programa>();
    if( data['programas'] != null) {
        data['programas'].forEach((programa){
        resumenProgramas.add(new Programa.resumefromJson(programa));
      });
    }
    else{
      print('Error el usuario no tiene lista de progras');

    }
    return resumenProgramas;
  }
}