// Scaffold(
//       appBar: AppBar(
//         title: Text('KROTIC Programación Remota '),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             ),
//           tooltip: 'Navigation menu',
//           onPressed: null,
//           ),
//         ),
//       body: 
//           Column(
//             children: <Widget>[
//               Expanded(
//                 child: Row(
//                   children: [
//                     Flexible(
//                         child: TextField(
//                           decoration: const InputDecoration(hintText: 'Ingrese un nombre para el programa'),
//                           controller: null,                  
//                       ),
//                     ),
//                     ButtonBar(
//                       children: <Widget> [
//                         FlatButton(onPressed: null, child: Text('Guardar')),
//                         FlatButton(onPressed: null, child: Text('Enviar')),
//                       ]
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: [
//                     Flexible(
//                       child: ListView(
//                         children: [
//                           Text('Instruccion 1'),
//                           Text('Instruccion 2'),
//                           Text('Instruccion 3'),
//                         ],
//                       ),
//                     ),
//                     // ListView(),
//                   ],

//                 )
//               ),
//             ],
//           ),
//     );