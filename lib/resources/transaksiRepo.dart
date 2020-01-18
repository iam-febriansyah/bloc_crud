import 'package:bloc_crud/models/modelTransaksi.dart';
import 'package:bloc_crud/resources/transaksiApi.dart';

class TransaksiRepo{
  final TransaksiApi transaksiApi = TransaksiApi();
  Future<List<ModelTransaksi>> fetchAllModelTransaksi(String idUser) => transaksiApi.fetchTransaksiList(idUser);
}