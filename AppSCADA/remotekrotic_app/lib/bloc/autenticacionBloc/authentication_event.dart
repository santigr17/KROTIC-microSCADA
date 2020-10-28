import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:remotekrotic_app/models/usuarios_model.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UsuarioLoggedIn extends AuthenticationEvent {
  final Usuario user;

  UsuarioLoggedIn({@required this.user});
  
  @override
  List<Object> get props => [user];
}

class UsuarioLoggedOut extends AuthenticationEvent {}
