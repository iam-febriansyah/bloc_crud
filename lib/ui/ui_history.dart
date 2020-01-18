import 'package:bloc_crud/ui/ui_home.dart';
import 'package:flutter/material.dart';
import 'package:bloc_crud/blocs/blocHistory.dart';
import 'package:bloc_crud/models/modelTransaksi.dart';
import 'package:bloc_crud/constant.dart';

class History extends StatefulWidget {
  final String getIdUser;
  History({ Key key, @required this.getIdUser }) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(left: 1.0, right: 1.0, top: 5.0, bottom: 5.0) ,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "History Kendaraan Kamu",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 50, 
              )
            ),
          ),
        ),
      ),
      body: ListData(idUser : widget.getIdUser),
    );
  }

  
}

class ListData extends StatefulWidget {
  final String idUser;
  ListData({ Key key, @required this.idUser }) : super(key: key);
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  void initState() { 
    blocHistory.fetchAllTodo(widget.idUser); 
    super.initState();
  }
  void disopose(){
    blocHistory.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocHistory.allTodo,
      builder: (BuildContext context, AsyncSnapshot<List<ModelTransaksi>> snapshot) {
        if(snapshot.hasData){
          print(snapshot.data.length);
            return listDataColumn(snapshot);
          
        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }else{
          return Center(child: Text(snapshot.error.toString()),);
        }
      }
    );
  }

  Widget listDataColumn(AsyncSnapshot<List<ModelTransaksi>> snapshot){
    SizeConfig().init(context);

    return CustomScrollView(
      slivers: <Widget>[
       
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.height / 400,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // final ModelTransaksi putData = snapshot.data[index];
              if(snapshot.data[index].status != 'false'){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                  height: SizeConfig.blockVertical * 5,
                  width: SizeConfig.blockHorizontal * 95,
                  child: Container(
                    margin: const EdgeInsets.only(left: 1.0, right: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snapshot.data[index].nopol.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Jam Datang kamu  : " + snapshot.data[index].createdDate.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Jam Mulai Di Cuci  : " + snapshot.data[index].dateProcess.toString() ,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Jam Selesai Di Cuci  : " + snapshot.data[index].dateFinish.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              );
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Ups, kendaraan kamu belum pernah di cuci disini sob")),
                );
              }

            },
            childCount: snapshot.data.length,
          ),
        )
      ]
    );
  }
}