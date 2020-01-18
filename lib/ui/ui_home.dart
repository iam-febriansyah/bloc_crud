import 'dart:async';
import 'package:bloc_crud/blocs/blocActivity.dart';
import 'package:bloc_crud/blocs/blocLogin.dart';
import 'package:bloc_crud/constant.dart';
import 'package:bloc_crud/ui/ui_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
}
 
class _Home extends State<Home>{
  SharedPreferences sharedPrefs;
  void initState(){
    super.initState();
  }

  Future<void> _getPrefs() async{
    sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;    
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HeaderSection(idUser: sharedPrefs.getString('id_user'));
                }return CircularProgressIndicator();
              }
            ),
            FutureBuilder(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: SizeConfig.blockHorizontal * 7.5),
                              child: Text( 
                                sharedPrefs.getString('username').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.blue[700],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPaint(painter: Drawhorizontalline()),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            FutureBuilder(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BodySectionOne(idUser: sharedPrefs.getString('id_user'));
                }return CircularProgressIndicator();
              }
            ),
            BodySectionTwo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          blocLogin.postLogout(context);
        },
        label: Text('K E L U A R'),
        icon: Icon(Icons.open_in_new),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  
  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 2
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

class HeaderSection extends StatefulWidget {
  final String idUser;
  HeaderSection({Key key, @required this.idUser}) : super(key: key);
  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}


class _HeaderSectionState extends State<HeaderSection> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      height: SizeConfig.blockVertical * 25,
      width: SizeConfig.blockHorizontal * 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/wave.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CupertinoButton(
            child: Container(
              height: SizeConfig.blockVertical * 15,
              width: SizeConfig.blockHorizontal * 33,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                image: DecorationImage(
                  image: AssetImage("assets/imgs/user.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              blocLogin.getProfile(context, widget.idUser);
            },
          ),
        ),
      ),
    );
  }
}

class BodySectionOne extends StatefulWidget {
  final String idUser;
  BodySectionOne({Key key, @required this.idUser}) : super(key: key);
  @override
  _BodySectionOneState createState() => _BodySectionOneState();
}

class _BodySectionOneState extends State<BodySectionOne> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          child: Container(
            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
            height: SizeConfig.blockVertical * 20,
            width: SizeConfig.blockHorizontal * 40,
            child: Container(
              margin: const EdgeInsets.only(left: 1.0, right: 0.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue[600],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage("assets/imgs/car-wash.png"),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  "Aktivitas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          onPressed: () {
            blocActivity.getActivity(context, widget.idUser);
          },
        ),

        CupertinoButton(
          child: Container(
            height: SizeConfig.blockVertical * 20,
            width: SizeConfig.blockHorizontal * 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue[600],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: AssetImage("assets/imgs/clock.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Text(
                "History",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) =>
                  History(
                    getIdUser : widget.idUser
                    )
                  ),
            );
          },
        ),
      ],
    );
  }
}

class BodySectionTwo extends StatefulWidget {
  @override
  _BodySectionTwoState createState() => _BodySectionTwoState();
}

class _BodySectionTwoState extends State<BodySectionTwo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          child: Container(
            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
            height: SizeConfig.blockVertical * 20,
            width: SizeConfig.blockHorizontal * 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue[600],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: AssetImage("assets/imgs/key-chain.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Text(
                "Accesoris",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text('Card is clicked.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('ok'),
                    onPressed: () {
                      Navigator.pop(context, 'ok');
                    },
                  ),
                ],
              ),
            );
          },
        ),

        CupertinoButton(
          child: Container(
            height: SizeConfig.blockVertical * 20,
            width: SizeConfig.blockHorizontal * 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue[600],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: AssetImage("assets/imgs/antre.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Text(
                "Antrian",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('Card is clicked.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('ok'),
                        onPressed: () {
                          Navigator.pop(context, 'ok');
                        },
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }
}