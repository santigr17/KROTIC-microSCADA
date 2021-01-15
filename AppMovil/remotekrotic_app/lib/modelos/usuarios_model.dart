
import 'programa.dart';

abstract class Usuario {
  int idUsuario;
  String username;
  String password;
  String nombre;
  int tipoUsuario;
  String institucion;
  Usuario({
    this.idUsuario,
    this.username,
    this.password,
    this.nombre,
    this.tipoUsuario,
    this.institucion = "Tecnologico Costa Rica",
  });
}

class Estudiante extends Usuario {
  List<Programa> programas;
  
  Estudiante (int userId, String nombre, String username, String password) 
    : super(idUsuario: userId, nombre: nombre, username: username, password: password, tipoUsuario :1);

  void setProgramas(List<Programa> listaProgramas) {
    this.programas = listaProgramas;
  }
}

class Encargado extends Usuario {
  List<Estudiante> estudiantes;
  Encargado (String nombre, String username, String password) 
    : super(nombre: nombre, username: username, password: password);  
}