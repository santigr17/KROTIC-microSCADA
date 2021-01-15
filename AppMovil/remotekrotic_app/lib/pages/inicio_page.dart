
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_event.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_state.dart';
import 'package:remotekrotic_app/bloc/navigator/NavigatorAction.dart';
import 'package:remotekrotic_app/bloc/navigator/NavigatorBloc.dart';
import 'package:remotekrotic_app/modelos/programa.dart';
import 'package:remotekrotic_app/modelos/usuarios_model.dart';
import 'package:remotekrotic_app/pages/editor_page.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';

class InicioEncargado extends StatelessWidget {
  final Encargado encargado; 

  InicioEncargado({Key key, this.encargado,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Bienvenido Encargado!"),);
  }
}

class InicioEstudiante extends StatelessWidget {
  final Estudiante estudiante;
  InicioEstudiante({Key key, @required this.estudiante}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    var _storage;// = RepositoryProvider.of<LocalStorage>(context);
    // final _inicioBloc = //BlocProvider.of<InicioBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("KROTIC-microSCADA"),),
      body: RepositoryProvider(
        create: (context) {  },
        child: BlocProvider(
          create: (context)=> InicioBloc(LocalStorage()),
          child: BlocListener<InicioBloc, InicioState>(
              listener: (context, state) {
                if(state is AbriendoEditor){
                  return Center(child: Text("HOLIS"),);
                }
              },
              child: BlocBuilder<InicioBloc,InicioState>(
                builder: (context, state){
                  if(state is ListaProgramas){
                      return PrograsView(progras: state.programas,estudiante: estudiante);
                    }
                  if(state is AbriendoEditor){
                    return EditorPrograma(user: estudiante,);
                  } 
                  else{
                    var _inicioBloc = BlocProvider.of<InicioBloc>(context);
                    _inicioBloc.add(CargarDatos(estudiante));
                    return Center(
                          child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
          ),
          ),
      )
    );
  }
}
 
class PrograsView extends StatelessWidget{
  final List<Programa> progras;
  final Estudiante estudiante;

  const PrograsView({Key key, this.progras, this.estudiante}) : super(key: key);
  @override
  Widget build(BuildContext context) 
  {
    final inicioBloc = BlocProvider.of<InicioBloc>(context);
    return Container(
            alignment: Alignment.center,
            child:
            Container(
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => {
                      BlocProvider.of<NavigatorBloc>(context).add(NavegarEditor(estudiante))
                     }, 
                    label: Text("CREAR PROGRAMA"),
                    icon: Icon(Icons.add),
                    ),
                  ElevatedButton.icon(
                    onPressed: () => {}, //inicioBloc.add(CrearProgra(estudiante))
                    label: Text("ACTUALIZAR"),
                    icon: Icon(Icons.sync_rounded),
                    ),
              ],),
              if(progras!=null)
                Expanded(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left:10,top:20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("PROGRAMAS ANTERIORES:",
                                style: TextStyle(fontSize: 20),),
                            ),
                          ),
                        Flexible (
                          child: ListView.separated(
                            padding: const EdgeInsets.all(2),
                            itemCount: progras.length,
                            itemBuilder: (context, int indice) {
                              return PrograItem(item: progras[indice],);
                            }, 
                            separatorBuilder: (BuildContext context, int index) => Divider(),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ) 
    );
  }
}

class PrograItem extends StatelessWidget{
  final Programa item;

  const PrograItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var remoteIcon = Icons.cloud_upload_outlined;
    if(item.estado == "enviado")
      remoteIcon = Icons.hourglass_bottom_outlined ;
    if(item.estado == "listo")
      remoteIcon = Icons.cloud_done_outlined;
    return Container(
      margin: const EdgeInsets.all(10),    

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Text(
          item.nombrePrograma,
          style: TextStyle(fontSize: 25),
        ),
        Text("Estado:${item.estado}"),
        Text(item.fechaCreacion),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.edit_outlined), onPressed: () => {}),
            IconButton(icon: Icon(Icons.view_in_ar), onPressed: ()=>{}),
            IconButton(icon: Icon(remoteIcon), onPressed: ()=>{}),
            IconButton(icon: Icon(Icons.ondemand_video), onPressed: ()=>{}),
            Container(),
            Container(),
            IconButton(icon: Icon(Icons.delete), onPressed: ()=>{}),
        ],)
      ],),
    );
  }
}


