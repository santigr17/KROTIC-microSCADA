
import 'package:equatable/equatable.dart';
import 'package:remotekrotic_app/models/modulo.dart';

abstract class ModuloEvent extends Equatable {}

class FetchModulosEvent extends ModuloEvent {
    @override
    List<Object> get props => [];
}
// class unselectModulo extends ModuloEvent {
//   unselectModulo(Modulo module) : super(module);
// }
// class VerDescripcion extends ModuloEvent {
//   VerDescripcion(Modulo module) : super(module);
// }


