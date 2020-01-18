import 'package:bloc_crud/models/modelTransaksi.dart';
import 'package:bloc_crud/resources/transaksiRepo.dart';
import 'package:rxdart/rxdart.dart';

class BlocHistory{
  final TransaksiRepo _repository = TransaksiRepo();
  final PublishSubject<List<ModelTransaksi>> _todoFetcher = PublishSubject<List<ModelTransaksi>>();
  Observable<List<ModelTransaksi>> get allTodo => _todoFetcher.stream;
  dynamic fetchAllTodo(String idUser) async {
    final List<ModelTransaksi> todo = await _repository.fetchAllModelTransaksi(idUser) ;
    _todoFetcher.sink.add(todo);
  }
  dynamic dispose(){
    _todoFetcher.close();
  }
}

final BlocHistory blocHistory = BlocHistory();