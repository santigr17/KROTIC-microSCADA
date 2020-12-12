
import 'package:bloc/bloc.dart';
import 'package:remotekrotic_app/models/instruccion.dart';
import 'package:remotekrotic_app/models/modulo.dart';
import 'package:remotekrotic_app/models/programa.dart';
import 'package:remotekrotic_app/pages/instruccion_page.dart';
import 'package:remotekrotic_app/services/localDB/localStorage.dart';

import 'editorEvent.dart';
import 'editorState.dart';

class EditorBloc extends Bloc<EditorEvent,EditorState>{
  LocalStorage _storageService;
  bool _esperarCondicion = false;
  List<Instruccion> instDisponibles;
  List<Modulo> modsDisponibles;
  List<dynamic> _vistaCodigo = [];
  List<List<dynamic>> _bloqueActual = [];
  Programa _newPrograma;
  
  EditorBloc(LocalStorage storageService) : super(Inicial()) {
    _storageService = storageService;
    this._newPrograma = Programa(instrucciones: []);
    this._bloqueActual.add(this._newPrograma.instrucciones);
  }

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
        yield Programando(this.instDisponibles,this._newPrograma,this._vistaCodigo);
      }
      else{
        yield ErrorRobot("Se deben agregar modulos para que el robot funcione");
      }
    }
    if(event is AgregarMientras){
      yield EsperandoDatos();
      Mientras instancia = Mientras.clone(event.newInstruccion); //Deep copy del objeto mientras
      instancia.bloque = [];
      instancia.anidado = this._newPrograma.ciclos;
      print("ADDING WHILE");
      this._bloqueActual.last.add(instancia);
      this._newPrograma.ciclos++;
      this._esperarCondicion = true;
      this._vistaCodigo.add(instancia);
      yield Programando(this.instDisponibles,this._newPrograma,this._vistaCodigo);
      
    }

    if(event is AgregarCondicion){
      yield EsperandoDatos();
      if(this._esperarCondicion){
        Mientras ciclo = this._bloqueActual.last.last;
        ciclo.condicion = event.newInstruccion;
        this._esperarCondicion = false;
        this._bloqueActual.add(ciclo.bloque);
        yield Programando(this.instDisponibles,this._newPrograma,this._vistaCodigo);
      }
      else{
        // LLAMAR A ERROR USANDO CONDICION CUANDO NO SE DEBE
        this.add(MostrarError("NO SEA MAMON EN CONDICION"));
      }
    }
    
    if(event is AgregarInstruccion)
    {
      yield EsperandoDatos();
      if(!this._esperarCondicion)
      {
        Instruccion instancia = Instruccion.clone(event.newInstruccion);
        instancia.anidado = this._newPrograma.ciclos;
        if(instancia.idInstruccion == finID){
          if(this._newPrograma.ciclos > 0){
            this._newPrograma.ciclos--;
            this._bloqueActual.removeLast();
          }
          else{
            this._newPrograma.finalizado = true;
          }
        }

        this._bloqueActual.last.add(instancia);
        this._vistaCodigo.add(instancia);
        yield Programando(this.instDisponibles,this._newPrograma,this._vistaCodigo);
      }
      else 
      {
        this.add(MostrarError("ESCOJA UNA CONDICION MALDITO"));
      }
    }
  }
}