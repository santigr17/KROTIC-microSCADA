import 'package:bloc/bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_event.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_state.dart';
import 'package:remotekrotic_app/pages/inicio_page.dart';

class InicioBloc extends Bloc<InicioEvent,InicioState>{
  InicioBloc(InicioState initialState) : super(initialState);

  // final StorageService _storage;
  // InicioBloc(StorageService storage) 
  //   : assert(storage != null)
  //    super(initialState);

  @override
  Stream<InicioState> mapEventToState(InicioEvent event) {
    
  }

}