
import 'package:bloc_crud/LoginScreen.dart';
import 'package:bloc_crud/SignUpScreen.dart';
import 'package:bloc_crud/constant.dart';
import 'package:bloc_crud/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        LOGIN_SCREEN: (BuildContext context) => LogInScreen(),
        ANIMATED_SPLASH: (BuildContext context) => SplashScreen()
      },
    );
  }
}