import 'dart:async';
import 'package:quiver/async.dart';
import 'package:bloc_crud/blocs/blocLogin.dart';
import 'package:bloc_crud/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPScreen extends StatefulWidget {
  final String nohp;
  OTPScreen({Key key, @required this.nohp}) : super(key: key);
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<OTPScreen>
  with SingleTickerProviderStateMixin {
  final TextEditingController otpController =  TextEditingController();
  final TextEditingController notelpController =  TextEditingController();
  bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    });
  }

  Timer _timer;
  int _start = 60;
  int _current = 60;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      print(widget.nohp);
      print("Done");
      sub.cancel();
      blocLogin.postTimeOut(context, widget.nohp);
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomPadding: true,
        body:  ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child:  Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop(LOGIN_SCREEN);
                                }
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 0.0, top: 0.0),
                            child:  Text(
                              widget.nohp,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Image.asset(
                      'assets/imgs/car.png',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.scaleDown,
                    )
                  ],
                ),
                Center(
                  child: Center(
                    child:  Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child:  Form(
                              autovalidate: false,
                              child:  Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    child:  TextFormField(
                                      onChanged: blocLogin.postNumberOTP,
                                      controller: otpController,
                                      decoration:  InputDecoration(
                                        labelText: 'Masukkan kode OTP disini',
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0, top: 45.0, bottom: 20.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(30.0)
                                      ),
                                      onPressed: () {
                                      if (!(otpController.value.text.toString().trim().isNotEmpty)){
                                        Fluttertoast.showToast(
                                          msg: 'Jangan lupa masukkin OTP nya ya :)',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1
                                        );
                                      } else {
                                        blocLogin.postConfirmOTP(context);
                                      }
                                    },
                                    child: Text(
                                      'Konfirmasi',
                                      style:  TextStyle(
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
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                 )
                ),
                Center(
                  child: Text( 
                    "$_current",
                    style: TextStyle(
                      fontSize: 60,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 10
                        ..color = Colors.blue[700],
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      );
  }

  @override
  void dispose() {
    _timer.cancel();
    otpController.dispose();
    super.dispose();
  }
}
