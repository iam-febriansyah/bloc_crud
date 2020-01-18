import 'package:bloc_crud/blocs/blocLogin.dart';
import 'package:bloc_crud/constant.dart';
import 'package:bloc_crud/ui/ui_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Activity extends StatefulWidget {
  
  final String getNopol;
  final String getNama;
  final String getUsername;
  final String getNoTelp;
  final String getCreatedDate;
  final String getDateProcess;
  final String getDateFinish;
  final String getTotalBayar;
  Activity({
    Key key, 
    @required 
      this.getNopol, 
      this.getNama, 
      this.getUsername, 
      this.getNoTelp,
      this.getCreatedDate, 
      this.getDateProcess, 
      this.getDateFinish, 
      this.getTotalBayar
      
      }) : super(key: key);
  @override
  ActivityState createState() => ActivityState();
}

class ActivityState extends State<Activity>
  with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return  Scaffold(
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
          title: Container(
            height: 50,
            padding: const EdgeInsets.only(left: 1.0, right: 1.0, top: 5.0, bottom: 5.0) ,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Aktivitas Kamu Sekarang",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 50, 
                )
              ),
            ),
          ),
        ),
        body: 
        
        ListView(
          children: <Widget>[
            Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: SizeConfig.blockVertical * 20,
                    width: SizeConfig.blockHorizontal * 95,
                    child: 
                      widget.getDateProcess == "null" ? 
                        Image.asset("assets/imgs/antre.png")
                        : Image.network(
                          'https://media.giphy.com/media/12xNaEcV4630Ji/giphy.gif',
                        ),
                    
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.getDateProcess == "null" ? "Mobil kamu masih dalam antrian ya" 
                                      : "Mobil kamu lagi di cuci nih",
                  ),
                ),
                
                SizedBox(
                  height: 30.0,
                ),

                Container(
                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                  height: SizeConfig.blockVertical * 20,
                  width: SizeConfig.blockHorizontal * 95,
                  child: Container(
                    margin: const EdgeInsets.only(left: 1.0, right: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.getNopol,
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
                                  "Jam Datang kamu  " + widget.getCreatedDate,
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
                                  widget.getDateProcess == "null" ? "Mobil kamu masih dalam antrian ya" 
                                    : "Mobil kamu mulai di cuci  " + widget.getDateProcess,
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
                

                // if(widget.getCreatedDate == null){
              ],
          ),
            
            )
          ],
        )

      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
