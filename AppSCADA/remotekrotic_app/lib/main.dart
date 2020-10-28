
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/autenticacionBloc/authentication.dart';
import 'package:remotekrotic_app/pages/inicio_page.dart';
import 'package:remotekrotic_app/pages/login_page.dart';
import 'package:remotekrotic_app/services/authentication_service.dart';


void main() {
  runApp( RepositoryProvider<AuthenticationService>(create: (context){
    return FakeAuthenticationService();
  },
  child: BlocProvider<AuthenticationBloc>(
    create: (context){
      final authService = RepositoryProvider.of<AuthenticationService>(context);
      return AuthenticationBloc(authService)..add(AppLoaded());
    },
    child: MyApp(),

  ), )

  );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder:(context, state){
          if(state is AuthenticationAuthenticated){
            if(state.user.tipoUsuario == 1){
              return InicioEncargado( encargado: state.user,);
            }
            else{
              return InicioEstudiante( estudiante: state.user,);

            }            
          }
          return LoginPage();
        },
      ),
    );
  }
}