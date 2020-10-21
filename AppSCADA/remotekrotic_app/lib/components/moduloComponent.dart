import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/moduloCubit.dart';
import 'package:remotekrotic_app/models/modulo.dart';

class ModuloComponent extends StatelessWidget{
  final Modulo modulo;
  ModuloComponent(
    this.modulo,
  );

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<ModuloCubit, Modulo> (
     builder: (context, modulo)=> Center(child: Text(modulo.nombre),),
    );
  }
  
}
