import 'package:flutter/material.dart';
import 'package:prueba_tecnica/configurations/Firebase.dart';//import for initialization of firebase

import 'frames/Login.dart';//import for navigation

Future<void> main() async {
  initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login()
      );
  }
}