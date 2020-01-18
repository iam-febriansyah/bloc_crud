import 'package:bloc_crud/SignUpScreen.dart';
import 'package:bloc_crud/blocs/blocLogin.dart';
import 'package:bloc_crud/constant.dart';
import 'package:bloc_crud/ui/ui_home.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';


class LogInScreen extends StatefulWidget {
  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> with SingleTickerProviderStateMixin {
  Client client = Client();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noHPController = TextEditingController();
  bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(" Check status login : " +prefs.getString('username'));
    if(prefs.getString('status') != null){
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) =>
            Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body:
      Center(
        child: ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/imgs/car-wash.png',
                      height: 150.0,
                      width: 210.0,
                      fit: BoxFit.scaleDown,
                    )
                  ],
                ),
                
                Center(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Form(
                            autovalidate: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: TextField(
                                    onChanged: blocLogin.postUsername,
                                    controller: usernameController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      labelText: 'User Name*',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(right: 7.0),
                                        child:Image.asset(
                                          'assets/imgs/account.png',
                                          height: 15.0,
                                          width: 15.0,
                                          fit: BoxFit.scaleDown,
                                        )
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                  child: TextFormField(
                                    onChanged: blocLogin.postPassword,
                                    obscureText: _secureText,
                                    autofocus: false,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Password*',
                                      suffixIcon: IconButton(
                                        onPressed: showHide,
                                        icon: Icon(_secureText ? Icons.visibility : Icons.visibility_off)
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(right: 7.0),
                                        child: Image.asset(
                                            'assets/imgs/key.png',
                                            height: 15.0,
                                            width: 15.0,
                                            fit: BoxFit.scaleDown,
                                          )
                                      )
                                    ),
                                    keyboardType: TextInputType.text,
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0, top: 45.0, bottom: 20.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(30.0)
                                    ),
                                    onPressed: () {
                                      if (!(usernameController.value.text.trim().toString().length >1)) {
                                        Fluttertoast.showToast(
                                          msg: 'Please enter user name.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                        );
                                      } else if (!(passwordController.value.text.trim().toString().length >1)) {
                                        Fluttertoast.showToast(
                                          msg: 'Please enter the password.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                        );
                                      } else {
                                        blocLogin.postLogin(context);
                                      }
                                    },

                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    color: Color(0xFF54C5F8),
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    padding: const EdgeInsets.only(
                                      left: 80.0,
                                      right: 80.0,
                                      top: 15.0,
                                      bottom: 15.0
                                    ),
                                  ),
                                ),
                                
                                CustomPaint(painter: Drawhorizontalline()),
                                
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                  child: TextFormField(
                                    onChanged: blocLogin.postNoTelp,
                                    autofocus: true,
                                    controller: noHPController,
                                    decoration: InputDecoration(
                                      labelText: 'Nomor Handphone',
                                      suffixIcon: IconButton(
                                        onPressed: (){
                                          if (!(noHPController.value.text.trim().toString().length > 10 )) {
                                            Fluttertoast.showToast(
                                              msg: 'No Hape kurang dari 10 digit',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIos: 1
                                            );
                                          }else{
                                            blocLogin.postOTP(context);
                                          }
                                        },
                                        icon: Icon(Icons.send)
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                  )
                                ),

                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                              SignUpScreen()),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          'Belum punya akun? Coba klik disini',
                                          style: TextStyle(
                                            decoration:
                                            TextDecoration.underline,
                                            fontSize: 15.0
                                          ),
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  
  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
      canvas.drawLine(Offset(-180.0, 0.0), Offset(185.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
