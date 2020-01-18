// To parse this JSON data, do
//
//     final modelTransaksi = modelTransaksiFromJson(jsonString);

import 'dart:convert';

List<ModelTransaksi> modelTransaksiFromJson(String str) => 
  List<ModelTransaksi>.from(json.decode(str).map((x) => ModelTransaksi.fromJson(x)));

// String modelTransaksiToJson(List<ModelTransaksi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTransaksi {
    String status;
    String nopol;
    String username;
    String nama;
    String createdDate;
    String dateProcess;
    String dateFinish;
    String totalBayar;

    ModelTransaksi({
        this.status,
        this.nopol,
        this.username,
        this.nama,
        this.createdDate,
        this.dateProcess,
        this.dateFinish,
        this.totalBayar,
    });

    factory ModelTransaksi.fromJson(Map<String, dynamic> json) => ModelTransaksi(
        status: json["status"] == null ? null : json["status"],
        nopol: json["nopol"] == null ? null : json["nopol"],
        username: json["username"] == null ? null : json["username"],
        nama: json["nama"] == null ? null : json["nama"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        dateProcess: json["date_process"] == null ? null : json["date_process"],
        dateFinish: json["date_finish"] == null ? null : json["date_finish"],
        totalBayar: json["total_bayar"] == null ? null : json["total_bayar"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "nopol": nopol == null ? null : nopol,
        "username": username == null ? null : username,
        "nama": nama == null ? null : nama,
        "created_date": createdDate == null ? null : createdDate,
        "date_process": dateProcess == null ? null : dateProcess,
        "date_finish": dateFinish == null ? null : dateFinish,
        "total_bayar": totalBayar == null ? null : totalBayar,
    };
}
