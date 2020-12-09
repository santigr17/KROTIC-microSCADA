
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic> {

  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey}) : super(null);

  
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    if(event is NavigatorActionPop){
      navigatorKey.currentState.pop();
      
    }else if(event is NavegarInicioEstudiante){
      navigatorKey.currentState.pushNamed('/inicio_estudiante',arguments: event.estudiante);
    }
    else if(event is NavegarEditor){
      navigatorKey.currentState.pushNamed('/editor', arguments: event.estudiante);
    }
  }
}

