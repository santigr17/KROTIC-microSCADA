import 'programa.dart';

abstract class Usuario {
  String username;
  String password;
  String nombre;
  int tipoUsuario;
  String institucion;
  Usuario({
    this.username,
    this.password,
    this.nombre,
    this.institucion = "Tecnologico Costa Rica",
    this.tipoUsuario,
  });  
}

class Estudiante extends Usuario {
  List<Programa> programas;
  
  Estudiante (String nombre, String username, String password) 
    : super(nombre: nombre, username: username, password: password, tipoUsuario :0);
}



class Encargado extends Usuario {
  List<Estudiante> estudiantes;
  Encargado (String nombre, String username, String password) 
    : super(nombre: nombre, username: username, password: password);  
}