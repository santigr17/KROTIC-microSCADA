import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorBloc.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorEvent.dart';
import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/pages/instruccion_page.dart';


class AreaEditor extends StatelessWidget 
{
  final Programa programa;
  final List<dynamic> vistaCodigo;
  final List<dynamic> disponibles;

  const AreaEditor({Key key, this.programa, this.disponibles, this.vistaCodigo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _editorBloc = BlocProvider.of<EditorBloc>(context);
    return Container(
      // margin: EdgeInsets.only(top:10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
            children: [
              Text(
                "FUNCIONES DISPONIBLES",
                style:Theme.of(context).textTheme.subtitle2,
              ),
              Expanded(child: InstsDisponibles(listado: disponibles,)),
            ],)
          ),
          Expanded(
            flex: 2,
            child: DragTarget<dynamic>(
            builder: (BuildContext context, List<dynamic> candidateData, List<dynamic> rejectedData)
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "PROGRAMA PARA EL ROBOT KROTIC",
                    style: Theme.of(context).textTheme.subtitle2,
                    ),
                  if(programa.instrucciones.length == 0)
                    Flexible(
                      flex: 1,
                      child: Center(child: Text("ARRASTRE LAS FUNCIONES AQUÍ PARA FORMAR EL PROGRAMA"),)
                    ),
                  if(programa.instrucciones.length != 0)
                    Expanded(
                      flex: 3,
                      child: BloqueCodigo(codigo:this.vistaCodigo)
                    )
                ]
              );
            },
              onWillAccept: (data) {
                bool result = true;
                if(programa.finalizado){
                  // _editorBloc.add(ErrorFaltaCondicion());
                  result = false;
                }
                else if((data as Instruccion).idInstruccion == mientrasID){
                  print("WHILE DATA");
                  if(this.programa.ciclos >= 2){
                    // _editorBloc.add(ErrorFaltaCondicion());
                    print("Maxima anidacion");
                    result = false;
                  }
                }
                return result;
              },
              onAccept: (data) {
                if(data is Mientras){
                  print("Calling Mientras EVENT");
                  _editorBloc.add(AgregarMientras(data));
                }
                else if(data is Condicion){
                  print("Calling Condicion EVENT");
                  _editorBloc.add(AgregarCondicion(data));
                }
                else{
                  print("Calling Instruction EVENT");
                  _editorBloc.add(AgregarInstruccion(data));
                }
                return true;
              },
            ),
          )
        ],),
      );
  }
}

/**
 * Lista de instrucciones disponibles para programar
 */ 
class InstsDisponibles extends StatelessWidget {
  final List<Instruccion> listado;
  const InstsDisponibles({Key key, this.listado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(1),
      itemCount: listado.length,
      itemBuilder: (context, int indice) {
        return Draggable<dynamic>(
          data: listado[indice]   ,
          feedback: Container(
              child: Card(
                margin: EdgeInsets.all(5),
                color: Colors.grey[100],
                child: Text(listado[indice].nombre))
          ),
          child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left:10),
                  child: Text(
                    listado[indice].descripcion),
                ),
            ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),);
   }
  }
  

