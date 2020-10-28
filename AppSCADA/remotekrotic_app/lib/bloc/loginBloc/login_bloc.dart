import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/Exceptions/authentication_exception.dart';
import 'package:remotekrotic_app/bloc/autenticacionBloc/authentication_bloc.dart';
import 'package:remotekrotic_app/bloc/autenticacionBloc/authentication_event.dart';
import 'package:remotekrotic_app/services/authentication_service.dart';

import 'login_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService)
    : assert (authenticationBloc != null),
      assert (authenticationService != null),
      _authenticationBloc = authenticationBloc,
      _authenticationService = authenticationService,
      super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressed){
      yield* _mapLoginWithEmailToState(event);
    }
  }

  
  Stream<LoginState> _mapLoginWithEmailToState(LoginButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationService.signIn(event.username, event.password);
      if(user != null){
        _authenticationBloc.add(UsuarioLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
          yield LoginFailure(error: 'Something very weird just happened');
      }
      
    } on AuthenticationException catch(e){
      yield LoginFailure(error: e.message);
    
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}