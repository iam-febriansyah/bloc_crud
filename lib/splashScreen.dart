import 'dart:async';
import 'package:bloc_crud/LoginScreen.dart';
import 'package:flutter/material.dart';
 
class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState() => _SplashScreen();
}
 
class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  dynamic startTime() async {
    final _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInScreen()),
    );
  }

  void initState(){
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
 
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 65,
                      child: Text(""),
                  ),
                  Expanded(
                    flex: 35,
                    child: Image.asset(
                      'assets/imgs/shower.png',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Image.asset(
                'assets/imgs/car.png',
                height: 180.0,
                width: 180.0,
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 40,
              child: Text(
                "WoshWoshCar",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}