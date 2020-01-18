import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:http/src/response.dart' show Response;
import 'package:bloc_crud/constant.dart';
import 'package:bloc_crud/models/modelTransaksi.dart';

class TransaksiApi{
  Client client = Client();
  final String _url = ConfigURL().url;

  Future<List<ModelTransaksi>> fetchTransaksiList(String _idUser) async{
    print(_url);
    final Response response = await client.get("$_url/history/getData/$_idUser");
    if(response.statusCode == 200){
      print(json.decode(response.body));
      return compute(modelTransaksiFromJson, response.body);
      // return json.decode(response.body);
    }else{ 
      throw Exception('Failed to load data');
    }
  }
}