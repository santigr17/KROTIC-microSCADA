import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/robotBloc/moduloBloc.dart';
import 'package:remotekrotic_app/bloc/robotBloc/moduloEvent.dart';
import 'package:remotekrotic_app/bloc/robotBloc/moduloState.dart';
import 'package:remotekrotic_app/models/modulo.dart';

class RobotView extends StatelessWidget {
  ModuloBloc moduloBloc;
  @override
  Widget build(BuildContext context) {
    moduloBloc = BlocProvider.of<ModuloBloc>(context);
    moduloBloc.add(FetchModulosEvent());
    return Container(
      child: Column(
        children: [
          Text('Agregue los módulos que va a necesitar para el robot'),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    child: Container(
                      child: BlocBuilder<ModuloBloc,ModuloState>(
                        builder: (context, state) {
                          if(state is ModuloInitialState){
                            return buildLoading();
                          } else if(state is ModuloLoadingState){
                            return buildLoading();
                          } else if(state is ModuloLoadedState){
                            return buildListaModulos(state.modulos);
                          } else if(state is ModuloErrorState){
                            return buildErrorUi(state.mns);
                          } else {
                            return Container(child: Text("UNKNOWN STATE"),);
                          }
                        },
                      )
                  ),
                ),
                Flexible(
                  child: Image(image: AssetImage('assets/images/kroticbasic.jpg')), 
                )
              ]
            ),
          )
        ]
      )
    );
  }
}


  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

Widget buildListaModulos(List<Modulo> modulos) {
  return ListView.builder(
    itemCount: modulos.length,
    itemBuilder: (context, pos){
      return ListTile(
        title: Text(modulos[pos].nombre),
      );
  } );
}
