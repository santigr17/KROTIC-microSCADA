import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remotekrotic_app/modelos/instruccion.dart';

// CONSTANTE
var styleCodigo = TextStyle(
  fontWeight: FontWeight.bold,
  color:Colors.white
);


/**
 * Visualización del bloque de código
 */
class BloqueCodigo extends StatelessWidget{
  final List<dynamic> codigo;
  const BloqueCodigo({Key key, this.codigo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(this.codigo);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        print("Codigo:codigo");
        print((codigo[index] as Instruccion).codigo);
        if((codigo[index] as Instruccion).codigo == "iks03" ){
          return MientrasItem(item:(codigo[index] as Mientras));
        }
        else{
          return InstruccionItem(item:codigo[index]);
        }
      },
      itemCount: this.codigo.length, 
    );
  }
}
class InstruccionItem extends StatelessWidget {
  final Instruccion item;
  const InstruccionItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var color = Colors.blue;
    if(this.item.anidado == 1){
      color  = Colors.amber;
    }
    else if(this.item.anidado == 2){
      color  = Colors.teal;
    }      
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.item.nombre,
            style: styleCodigo,
          ),
          IconButton(icon: Icon(Icons.remove_circle, color: Colors.white,), onPressed:()=>{print("remove item: "+item.nombre)})
        ]
      ),
    ); 
  }
}

class MientrasItem extends StatelessWidget {
  final Mientras item;
  const MientrasItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var _editorBloc = BlocProvider.of<EditorBloc>(context);
    var color = Colors.blue;
    var acento = Colors.amber;
    if(this.item.anidado == 1){
      color  = Colors.amber;
      acento = Colors.teal;
    }
    return Container(
          color: color,
          child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        item.nombre,
                        style: styleCodigo,
                      ),
                      Container(
                        color: acento,
                        child: item.condicion == null 
                        ? Text(
                          "<CONDICIÓN>",
                          style: styleCodigo,
                        )
                        : Text(
                          item.condicion.nombre,
                          style: styleCodigo,
                          )
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.white), 
                        iconSize: 20,
                        onPressed: () => {
                          print("Eliminar Funcion")
                        }
                      )
                    ],
                  ),
                if(item.bloque == null || item.bloque.length == 0)
                  Container(
                    color: acento,
                    child: Text(
                      "<BLOQUE DE CODIGO>",
                      style: styleCodigo,
                      )
                  ),
              ],),
    );
  }
}

