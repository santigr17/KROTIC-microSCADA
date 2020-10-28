import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:remotekrotic_app/models/programa.dart';

// https://medium.com/flutter-community/implementing-bloc-pattern-for-parsing-json-from-api-5ac538d5179f


abstract class ProgramaStorage {
  Future<List<Programa>> getProgramas(); 
  Future<Programa> getPrograma(int idPrograma); 
}

class ProgramaStorageImp implements ProgramaStorage {
  @override
  Future<List<Programa>> getProgramas() async {
   
  }

  @override
  Future<Programa> getPrograma(int idPrograma) {
    // TODO: implement getPrograma
    throw UnimplementedError();
  }
}
