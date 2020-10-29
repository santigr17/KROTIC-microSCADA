
import 'package:bloc/bloc.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_event.dart';
import 'package:remotekrotic_app/bloc/inicioEstudianteBlob/inicio_state.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';

class InicioBloc extends Bloc<InicioEvent,InicioState>{
  final LocalStorage _storageService;
  InicioBloc(LocalStorage storageService) : 
    _storageService = storageService,
    super(Inicial());

  @override
  Stream<InicioState> mapEventToState(InicioEvent event) async* {
    if(event is CargarProgras){
      yield CargandoListaProgramas();
      final programas = await  _storageService.getListProgramas(event.user.userID);
      if(programas != null){
        this.add(PrograsCargadas(lista: programas, user: event.user));
      }
    }
    if(event is PrograsCargadas){
      yield ListaProgras(event.lista);
    }
  }
}