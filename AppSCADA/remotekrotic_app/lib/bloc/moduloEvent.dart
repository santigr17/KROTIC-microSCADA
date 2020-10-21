
import 'package:remotekrotic_app/models/modulo.dart';

abstract class ModuloEvent {
  final Modulo module;
  ModuloEvent(this.module);
}

class selectModulo extends ModuloEvent {
  selectModulo(Modulo module) : super(module);
}
class unselectModulo extends ModuloEvent {
  unselectModulo(Modulo module) : super(module);
}
class VerDescripcion extends ModuloEvent {
  VerDescripcion(Modulo module) : super(module);
}


