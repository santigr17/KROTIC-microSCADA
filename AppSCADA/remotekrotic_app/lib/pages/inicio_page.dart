import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_event.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_state.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class Inicio extends StatelessWidget {
  const Inicio({Key key,}) : super(key: key);
}

class InicioEncargado extends Inicio {
  final Encargado encargado;
  InicioEncargado({Key key, this.encargado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Bienvenido Encargado!"),);
  }
}

class InicioEstudiante extends Inicio {
  final Estudiante estudiante;
  InicioEstudiante({Key key, this.estudiante}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KROTIC-microSCADA"),),
      body: BlocBuilder<InicioBloc, InicioState>(
              builder: (context, state){
                if(state is CargandoListaProgramas){
                  return Container(
                    // child: Text("!Bienvenido Hola")
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if(state is ListaProgras){
                  return PrograsView(progras: state.programas,estudiante: estudiante);
                }
                if(state is CrearProgra){
                  return Container(child:Text("Creando un programa nuevo en otra vista"));
                }
                return Container(child: Text("Estado MC"));
          },)
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
                  onPressed: () => {inicioBloc.add(CrearProgra(estudiante))}, 
                  label: Text("CREAR PROGRAMA"),
                  icon: Icon(Icons.add),
                  ),
                ElevatedButton.icon(
                  onPressed: () => {inicioBloc.add(CrearProgra(estudiante))}, 
                  label: Text("ACTUALIZAR"),
                  icon: Icon(Icons.sync_rounded),
                  ),
            ],),
            if(progras!=null)
              Expanded (
                child: ListView.separated(
                  padding: const EdgeInsets.all(2),
                  itemCount: progras.length,
                  itemBuilder: (context, int indice) {
                    return PrograItem(item: progras[indice],);
                  }, 
                  separatorBuilder: (BuildContext context, int index) => Divider(), 
                ),
              ),
          ],),
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
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey)
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Text(
          item.nombrePrograma,
          style: TextStyle(fontSize: 25),
        ),
        Text("Estado:${item.estado}"),
        Text(item.fecha),
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


