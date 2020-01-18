import 'package:bloc_crud/blocs/blocLogin.dart';
import 'package:bloc_crud/ui/ui_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdateProfile extends StatefulWidget {
  
  final String getidUser;
  final String getNama;
  final String getUsername;
  final String getNoTelp;
  UpdateProfile({
    Key key, 
    @required 
      this.getidUser, 
      this.getNama, 
      this.getUsername, 
      this.getNoTelp}) : super(key: key);
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<UpdateProfile>
  with SingleTickerProviderStateMixin {
  final blocLogin = BlocLogin();
  final TextEditingController idUserController =  TextEditingController();
  final TextEditingController namaController =  TextEditingController();
  final TextEditingController usernameController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    idUserController.text = widget.getidUser;
    namaController.text = widget.getNama;
    usernameController.text = widget.getUsername;
    notelpController.text = widget.getNoTelp;
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
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        Home()),
                                  );
                                }
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 0.0, top: 0.0),
                            child:  Text(
                              'Update Profile Kamu Disini Ya',
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
                      'assets/imgs/user.png',
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
                                  Visibility(
                                    visible: false,
                                    child: TextFormField(
                                      controller: idUserController, 
                                      keyboardType: TextInputType.text,  
                                    ),
                                    
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: TextFormField(
                                      // onChanged: blocLogin.postUsername(usernameController.text),
                                      controller: usernameController,
                                      decoration:  InputDecoration(
                                        labelText: 'Username *',
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: TextFormField(
                                      // onChanged: blocLogin.postNama(namaController.text),
                                      controller: namaController,
                                      decoration:  InputDecoration(
                                        labelText: 'Nama Lengkap ',
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                    child:  TextFormField(
                                      obscureText: false,
                                      // onChanged: blocLogin.postNoTelp(notelpController.text),
                                      controller: notelpController,
                                      decoration:  InputDecoration(
                                        labelText: 'No Hape',
                                        enabled: true,
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                    child:  TextFormField(
                                      obscureText: true,
                                      onChanged: blocLogin.postPassword,
                                      controller: passwordController,
                                      decoration:  InputDecoration(
                                        labelText: 'Password *',
                                        enabled: true,
                                        filled: false,
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText ? Icons.visibility : Icons.visibility_off)
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: rePasswordController,
                                      decoration:  InputDecoration(
                                        labelText: 'Confirm Password *',
                                        enabled: true,
                                        filled: false,
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
                                      // if (!(usernameController.value.text.toString().trim().isNotEmpty)){
                                      //   Fluttertoast.showToast(
                                      //     msg: 'Jangan lupa masukkin username nya ya :)',
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIos: 1
                                      //   );
                                      // } else if (!(passwordController.value.text.toString().trim().isNotEmpty)) {
                                      //   Fluttertoast.showToast(
                                      //     msg: 'Jangan lupa masukkin password nya ya :)',
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIos: 1
                                      //   );
                                      // } else if (!(rePasswordController.value.text.toString().trim().isNotEmpty)){
                                      //   Fluttertoast.showToast(
                                      //     msg: 'Jangan lupa masukkin confirm password nya ya :)',
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIos: 1
                                      //   );
                                      // } else {
                                      //   if (rePasswordController.value.text.toString().endsWith(passwordController.value.text.toString())) {
                                          blocLogin.postEditProfile(context, 
                                            idUserController.text,
                                            namaController.text,
                                            usernameController.text,
                                            notelpController.text
                                          );
                                        // } else {
                                        //   Fluttertoast.showToast(
                                        //     msg:'Ups, passwordnya tidak sama. Coba lagi ya ',
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.CENTER,
                                        //     timeInSecForIos: 1
                                        //   );
                                        // }
                                      // }
                                    },
                                    child: Text(
                                      'Daftar',
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
                )
              ],
            )
          ],
        )
      );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    idUserController.dispose();
    namaController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    notelpController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}
