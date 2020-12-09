
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotekrotic_app/bloc/autenticacionBloc/authentication.dart';
import 'package:remotekrotic_app/bloc/navigator/NavigatorBloc.dart';
import 'package:remotekrotic_app/services/authentication_service.dart';

import 'Routes.dart';

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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>(
      create: (BuildContext context) => NavigatorBloc(navigatorKey: _navigatorKey),
      child: MaterialApp(
        title: 'KROTIC-microSCADA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        onGenerateRoute: (settings) { return CustomRouter.generateRoute(settings); },
        initialRoute: '/',
      ),
    );
  }
}