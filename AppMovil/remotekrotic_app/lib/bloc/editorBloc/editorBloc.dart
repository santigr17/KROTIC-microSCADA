
import 'package:bloc/bloc.dart';
import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';

import 'editorEvent.dart';
import 'editorState.dart';

class EditorBloc extends Bloc<EditorEvent,EditorState>{
  LocalStorage _storageService;
  List<Instruccion> instDisponibles;
  List<Modulo> modsDisponibles;
  Programa _newPrograma;
  
  EditorBloc(LocalStorage storageService) :
    _storageService = storageService,
    this._newPrograma = Programa(instrucciones: []),
    super(Inicial());

  @override
  Stream<EditorState> mapEventToState(EditorEvent event) async* {
    if(event is CargarDisponibles){
      yield EsperandoDatos();
       this.modsDisponibles = await  _storageService.getModulos();
       this.instDisponibles = await  _storageService.getInstrucciones();
        if(this.instDisponibles != null && this.modsDisponibles != null){
          _newPrograma.robot=[];
          yield Equipando(this.modsDisponibles, _newPrograma.robot);
        }
    }
    if(event is EditarRobot){
        yield Equipando(this.modsDisponibles, event.robot);
    }
    if(event is EquiparModulo){
      this._newPrograma.robot.add(event.mod);
      yield EsperandoDatos();
      yield Equipando(this.modsDisponibles,this._newPrograma.robot);
    }
    if(event is DesequiparModulo){
      this._newPrograma.robot.remove(event.mod);
      yield EsperandoDatos();
      yield Equipando(this.modsDisponibles,this._newPrograma.robot);
    }
    if(event is ProgramarRobot){
      if(this._newPrograma.robot.length>1){
        yield Programando(this.instDisponibles,this._newPrograma);
      }
      else{
        yield ErrorRobot("Se deben agregar modulos para que el robot funcione");
      }
    }
    if(event is AgregarInstruccion){
      yield EsperandoDatos();
      print("Agregando instrucción");
      this._newPrograma.instrucciones.add(event.newInstruccion);
      yield Programando(this.instDisponibles,this._newPrograma);
    }
  }
}