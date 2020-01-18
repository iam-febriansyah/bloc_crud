import 'dart:convert';

import 'package:bloc_crud/LoginScreen.dart';
import 'package:bloc_crud/OTPScreen.dart';
import 'package:bloc_crud/ui/ui_home.dart';
import 'package:bloc_crud/ui/ui_updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' show Client;
import 'package:bloc_crud/constant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocLogin{
  Client client = Client();
  final _url = ConfigURL().url;
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _notelp = BehaviorSubject<String>();
  final _numberotp = BehaviorSubject<String>();
  final _nama = BehaviorSubject<String>();
  final _iduser = BehaviorSubject<String>();
  Function(String) get postUsername => _username.sink.add;
  Function(String) get postPassword => _password.sink.add;
  Function(String) get postNoTelp => _notelp.sink.add;
  Function(String) get postNumberOTP => _numberotp.sink.add;
  Function(String) get postNama => _nama.sink.add;
  Function(String) get postidUser => _iduser.sink.add;

  Stream<String> get idUserStream => _iduser.stream;

  postLogin(BuildContext context) async {
    var username = _username.value;
    var password = _password.value;
    final response = await client.post(
      "$_url/login/do_action",  
      body: {
        'username' : username, 
        'password' : password
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print(mapRes['status']);
      var status = mapRes['status'];
      if(status == 'true'){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('status', mapRes['status']);
        prefs.setString('id_user', mapRes['id_user']);
        prefs.setString('username', mapRes['username']);
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              Home()),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Ups, username / password salah :( ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  postReg(BuildContext context) async {
    var username = _username.value;
    var password = _password.value;
    var notelp = _notelp.value;
    final response = await client.post(
      "$_url/login/do_reg",  
      body: {
        'no_telp' : username, 
        'password' : password,
        'no_telp' : notelp
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print(mapRes['status']);
      var status = mapRes['status'];
      if(status == 'true'){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('status', mapRes['status']);
        prefs.setString('id_user', mapRes['id_user']);
        prefs.setString('username', mapRes['username']);
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              Home()),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Ups, username / password salah :( ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  postLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('status');
      prefs.remove('id_user');
      prefs.remove('username');
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => LogInScreen()));
  }

  postOTP(BuildContext context) async {
    var notelp = _notelp.value;
    final response = await client.post(
      "$_url/login/do_otp",  
      body: {
        'no_telp' : notelp
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print(mapRes['status']);
      var status = mapRes['status'];
      if(status == 'true'){
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              OTPScreen(nohp: notelp)),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Ups, ada yang salah. Coba lagi ya",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  postTimeOut(BuildContext context, nohp) async {
    print(nohp);
    var otp = 0;
    var notelp = nohp;
    final response = await client.post(
      "$_url/login/do_timeout",  
      body: {
        'no_telp' : notelp,
        'otp' : otp
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              LogInScreen()),
        );
    }
  }

  postConfirmOTP(BuildContext context) async {
    var otp = _numberotp.value;
    var notelp = _notelp.value;
    final response = await client.post(
      "$_url/login/do_confirm_otp",  
      body: {
        'no_telp' : notelp,
        'otp' : otp
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print(mapRes['status']);
      var status = mapRes['status'];
      if(status == 'true'){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('status', mapRes['status']);
        prefs.setString('id_user', mapRes['id_user']);
        prefs.setString('username', mapRes['username']);
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              Home()),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Ups, OTP salah :( ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  getProfile(BuildContext context, idUser) async {
    print("ID User blocLogin.dart : "+idUser);
    final response = await client.post(
      "$_url/login/do_getProfile",  
      body: {
        'id_user' : idUser,
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print(mapRes['username']);
      var namaEdit = mapRes['nama'];
      var usernameEdit = mapRes['username'];
      var notelpEdit = mapRes['no_telp'];
      Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              UpdateProfile(
                getidUser : idUser,
                getNama : namaEdit,
                getUsername : usernameEdit,
                getNoTelp : notelpEdit,
              )
          ),
        );
    }
  }

  postEditProfile(BuildContext context, 
    String iduser,
    String nama,
    String username,
    String notelp,
    ) async {
    var password = _password.value;
    print("print id user : " + iduser);
    print("print username : " + username);
    print("print password : " + password);
    print("print nama : " + nama);
    print("print notelp : " + notelp);
   
    final response = await client.post(
      "$_url/login/do_updateProfile",  
      body: {
        'id_user' : iduser, 
        'nama' : nama, 
        'username' : username, 
        'password' : password,
        'no_telp' : notelp
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print("Status update profile : " + mapRes['status']);
      var status = mapRes['status'];
      if(status == 'true'){
        Fluttertoast.showToast(
            msg: "Yeay, data berhasil kamu update :) ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              Home()),
        );
      }else{
        Fluttertoast.showToast(
            msg: "Ups, username / password salah :( ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }
  
  dispose(){
    _username.close();
    _password.close();
    _notelp.close();
    _numberotp.close();
    _nama.close();
    _iduser.close();
  }
}

final blocLogin = BlocLogin();