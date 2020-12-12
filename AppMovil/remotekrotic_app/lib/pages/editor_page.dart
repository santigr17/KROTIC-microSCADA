import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorBloc.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorEvent.dart';
import 'package:remotekrotic_app/bloc/editorBloc/editorState.dart';
import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';

import 'codigo_page.dart';

class EditorPrograma extends StatelessWidget {
  final Estudiante user;
  final List<Modulo> robot;
  final List<Instruccion> programa;
  EditorPrograma({Key key, this.user, this.robot, this.programa}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Scaffold(
      appBar: AppBar(title: const Text("KROTIC-microSCADA"),),
      body: BlocProvider (
        create: (context) => EditorBloc(LocalStorage()),
        child: BlocBuilder<EditorBloc, EditorState>(
          builder: (context, state) {
            if(state is Equipando){
              return Column(
                children: <Widget>[
                  Expanded(child: Encabezado(btnEnviar: false)),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "MÓDULOS DISPONIBLES",
                                style:Theme.of(context).textTheme.subtitle2,
                              ),
                              Expanded(child: ModsDisponibles(listado: state.equipos, robot: state.robot)),
                            ],
                          )
                        ),
                        Expanded(
                          child: Image(image: AssetImage('assets/images/kroticbasic.jpg'))
                          )
                        ]
                    )
                  )
                ]
              );
            }
            if(state is ErrorRobot){
              return AlertDialog(
                title: Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Error equipando el robot.'),
                      Text(state.msgError),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Entendido'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
            if(state is Programando)
            {
              return Column(
                children: <Widget>[
                  Flexible(child:Encabezado(btnEnviar: true, robot: state.prograActual.robot)),
                  Expanded(
                    // flex: 2,
                    child: AreaEditor(
                      programa: state.prograActual,
                      disponibles: state.disponibles,
                      vistaCodigo: state.codigo,
                    ),
                  )
                ],
              );
           }
            else {
              var _editorBloc = BlocProvider.of<EditorBloc>(context);
              _editorBloc.add(CargarDisponibles());
              return Center( child: CircularProgressIndicator(), );
            }
          },
        ),
      ),
    );
  }
}

class Encabezado extends StatelessWidget{
  final bool btnEnviar;
  final List<Modulo> robot;
  final List<Instruccion> programa;
  Encabezado({this.btnEnviar, this.robot, this.programa});

  @override
  Widget build(context) {
    var _editorBloc = BlocProvider.of<EditorBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextField(
              decoration: InputDecoration(
                labelText: 'Nombre del programa',
              ),
            ),
        ),
        Flexible(
          child: ElevatedButton.icon(
              onPressed: () => {}, //inicioBloc.add(CrearProgra(estudiante))
              label: Text("GUARDAR"),
              icon: Icon(Icons.save),
            ),
        ),
        
        if(this.btnEnviar)
          Flexible(
              child: ElevatedButton.icon(
              onPressed: () => {}, //inicioBloc.add(CrearProgra(estudiante))
              label: Text("ENVIAR"),
              icon: Icon(Icons.send_outlined),
            ),
          )
        
        else
          Flexible(
            child: ElevatedButton.icon(
                onPressed: () => {
                  _editorBloc.add(ProgramarRobot(this.robot))
                },
                icon: Icon(Icons.check),
                label: Text("ROBOT LISTO"),
            ),
          )
      ],
    );
  }
}

class ModsDisponibles extends StatelessWidget{
  final List<Modulo> listado;
  final List<Modulo> robot;
  ModsDisponibles({this.listado, this.robot,});

  @override
  Widget build(context) {
    return ListView.separated(
      padding: const EdgeInsets.all(1),
      itemCount: listado.length,
      itemBuilder: (context, int indice) {
        bool check = robot.contains(listado[indice]);
        return ModItem(item: listado[indice], selected: check,);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),);
  }
}

class ModItem extends StatelessWidget {
  final Modulo item;
  final bool selected;
  const ModItem({
    Key key,
    this.item,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(context) {
    var _editorBloc = BlocProvider.of<EditorBloc>(context);
    return Row(
      children: [
        Expanded(
          child: Column(children: [
            Text(item.nombre),
            Text(item.descripcion)
          ],)
        ),
        Checkbox(
          value: this.selected,
          onChanged: (val) => {
            if(this.selected){
              _editorBloc.add(DesequiparModulo(item))
            }
            else{
              _editorBloc.add(EquiparModulo(item))
            }
          },
        )
      ]
    );
  }
}

