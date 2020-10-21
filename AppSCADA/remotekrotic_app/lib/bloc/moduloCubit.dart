import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/models/modulo.dart';

class ModuloCubit extends Cubit<Modulo> {
  ModuloCubit(Modulo state) : super(state);
  void seleccionar() => emit(state.equipar());
  void deseleccionar() => emit(state.quitar());
}