import 'dart:convert';

import 'package:bloc_crud/ui/ui_activity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:bloc_crud/constant.dart';

class BlocActivity{
  Client client = Client();
  final _url = ConfigURL().url;

  getActivity(BuildContext context, idUser) async {
    print("No telpon blocActivity.dart : "+ idUser);
    final response = await client.post(
      "$_url/aktivitas/do_CurrentAktivitas",  
      body: {
        'id_user' : idUser,
      }
    );

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Ups, maaf gagal kirim data :( !");
    }else{
      Map mapRes = json.decode(response.body);
      print("Print sukses nopol : " + mapRes['nopol']);
      var nopolEdit = mapRes['nopol'].toString();
      var usernameEdit = mapRes['username'].toString();
      var namaEdit = mapRes['nama'].toString();
      var notelpEdit = mapRes['no_telp'].toString();
      var createdDateEdit = mapRes['created_date'].toString();
      var dateProcessEdit = mapRes['date_process'].toString();
      var dateFinishEdit = mapRes['date_finish'].toString();
      var totalBayarEdit = mapRes['total_bayar'].toString();
      Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
              Activity(
                getNopol : nopolEdit,
                getUsername : usernameEdit,
                getNama : namaEdit,
                getNoTelp : notelpEdit,
                getCreatedDate : createdDateEdit,
                getDateProcess : dateProcessEdit,
                getDateFinish : dateFinishEdit,
                getTotalBayar : totalBayarEdit
              )
          ),
        );
    }
  }

  
  dispose(){
    // _username.close();
    // _password.close();
    // _notelp.close();
    // _numberotp.close();
    // _nama.close();
    // _iduser.close();
  }
}

final blocActivity = BlocActivity();