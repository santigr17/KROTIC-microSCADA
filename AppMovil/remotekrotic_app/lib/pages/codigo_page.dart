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
  final Programa codigo;
  final List<Instruccion> disponibles;

  const AreaEditor({Key key, this.codigo, this.disponibles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _editorBloc = BlocProvider.of<EditorBloc>(context);
    return Container(
      child: Row(
        children: [
          Flexible(child: InstsDisponibles(listado: disponibles,)),
          Expanded(
            flex: 2,
            child: DragTarget<Instruccion>(
              builder: (BuildContext context, List<dynamic> candidateData, List<dynamic> rejectedData)
              {
                return Container(
                  child: Center (
                    child:  codigo.instrucciones.length != 0 
                    ? BloqueCodigo(codigo:codigo)
                    : Container (child: Text("Arrastre las funciones para formar el codigo"),)
                  ),
                );
              },
              onWillAccept: (data) {return true;},
              onAccept: (data) {
                print("Instruccion aceptada");
                _editorBloc.add(AgregarInstruccion(data));
                return true;
              },
            ),)
        ],),
      );
  }

}

class BloqueCodigo extends StatelessWidget{
  final Programa codigo;
  const BloqueCodigo({Key key, this.codigo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return InstruccionItem(item:codigo.instrucciones[index]);

      },
      itemCount: this.codigo.instrucciones.length, 
      separatorBuilder: (BuildContext context, int index) => Divider()
    );
  }
}


class InstsDisponibles extends StatelessWidget {
  final List<Instruccion> listado;
  const InstsDisponibles({Key key, this.listado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(1),
      itemCount: listado.length,
      itemBuilder: (context, int indice) {
        return Draggable<Instruccion>(
          data: listado[indice],
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
                    listado[indice].nombre),
                ),
            ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),);
   }
  }
  