
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
String
    LOGIN_SCREEN = '/LogInScreen',
    SIGN_UP_SCREEN = '/SignUpScreen',
    ANIMATED_SPLASH = '/SplashScreen';

class ConfigURL{
  String url = 'http://192.168.43.204/woshwoshcar/api/';
}

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockHorizontal;
  static double blockVertical;
  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockHorizontal = screenWidth / 100 ;
    blockVertical = screenHeight / 100 ;
  }
}

class SessionLogin{
  static Future getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}