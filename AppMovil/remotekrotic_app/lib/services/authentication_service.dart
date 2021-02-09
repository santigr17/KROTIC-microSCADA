 
 import 'package:remotekrotic_app/Exceptions/authentication_exception.dart';
import 'package:remotekrotic_app/modelos/usuarios_model.dart';


abstract class AuthenticationService {
  Future<Usuario> getCurrentUser();
  Future<Usuario> signIn(String email, String password);
  Future<void> signOut();
}


class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<Usuario> getCurrentUser() async {
    return null; // return null for now
  }

  @override
  Future<Usuario> signIn(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    // if (email.toLowerCase() != 'estudiante' || password != 'pass123') {
    //   throw AuthenticationException(message: 'Wrong username or password');
    // }
    return Estudiante(0,"Santiago Gamboa Ramírez","santigr17","pass123");
  }

  @override
  Future<void> signOut() {
    return null;
  }
}