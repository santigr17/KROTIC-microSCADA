import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/models/modulo.dart';

import 'moduloEvent.dart';
import 'moduloState.dart';


class ModuloBloc extends Bloc<ModuloEvent, ModuloState> {
  List<Object> storage;
  
  ModuloBloc({@required this.storage}) : super(null);

  @override
  Stream<ModuloState> mapEventToState(ModuloEvent event) async* {
    if(event is FetchModulosEvent){
      yield ModuloLoadingState();
      try {
        List<Modulo> modulos = [];//await storage.getModules();
        yield ModuloLoadedState(modulos: modulos);
      } catch (e) {
        yield ModuloErrorState(mns: e.toString());
      }
    }
  }
}