
import 'package:bloc/bloc.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';
import 'inicio_state.dart';
import 'inicio_event.dart';


class InicioBloc extends Bloc<InicioEvent,InicioState>{
  final LocalStorage _storageService;
  InicioBloc(LocalStorage storageService) : 
    _storageService = storageService,
    super(Inicial());

  
  // InicioState get initialState => Inicial();

  @override
  Stream<InicioState> mapEventToState(InicioEvent event) async* {
    if(event is CargarDatos){
      yield EsperandoDatos();
      if(event.user.tipoUsuario == 1){
        final programas = await  _storageService.getListProgramas(event.user.userID);
        if(programas != null){
          this.add(ProgramasCargados(lista: programas, user: event.user));
        }
      }
      else if(event.user.tipoUsuario == 2){
        final estudiantes = [];//await  _storageService.getListProgramas(event.user.userID);
        if(estudiantes != null){
          this.add(EstudiantesCargados(lista: estudiantes, user: event.user));
        }
      }
    }
    if(event is ProgramasCargados){
      yield ListaProgramas(event.lista);
    }
    if(event is Inicial){
      this.add(CargarDatos(event.user));
    }
  }
}