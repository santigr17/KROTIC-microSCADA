import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:remotekrotic_app/models/modulo.dart';

// https://medium.com/flutter-community/implementing-bloc-pattern-for-parsing-json-from-api-5ac538d5179f


abstract class ModuleStorage {
  Future<List<Modulo>> getModules(); 
}

class ModuleStorageImp implements ModuleStorage {
  @override
  Future<List<Modulo>> getModules() async {
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
}
