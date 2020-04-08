import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:softwareviewer/domain/computer.dart';
import 'package:softwareviewer/screens/software.dart';
import 'package:softwareviewer/services/access.dart';

class ComputersList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ComputersListState();
}

class ComputersListState extends State<ComputersList>{
  AccessService authService = AccessService();
  List<Computer> computers = List<Computer>();
//  List<Sheet> sheetsData;
  List<List<Object>> values;

  _load() async {
    authService.spreadSheet.then((spreadSheet) {
      spreadSheet.sheets.forEach((sheet) {
        authService.sheetValues('${sheet.properties.title}!A1:B${sheet.properties.gridProperties.rowCount}').then((value) {
          setState(() {
            values = value.toJson()['values'];
            List<Software> software = List<Software>();
            for(int i = 2; i < values.length; i++){
              software.add(
                Software(
                  values.elementAt(i).elementAt(0),
                  values.elementAt(i).length > 1 ? values.elementAt(i).elementAt(1) : "Version unknown"
                )
              );
            }
            computers.add(
              Computer(
                name: sheet.properties.title,
                updateDate: DateTime.fromMillisecondsSinceEpoch(int.parse(values.elementAt(0).elementAt(1))*1000),
                software: software,
              )
            );
            computers = List.from(computers.toSet());
            computers.sort((c1,c2) => c1.name.compareTo(c2.name));
          });
        });
      });
    });
  }

  @override
  initState() {
    super.initState();
    _refresh();
  }

  @override
  dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 10),
          child: ResponsiveGridList(
            desiredItemWidth: 300,
            minSpacing: 10,
            children: computers.map((computer) {
              return Container (
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(),
                  color: Colors.transparent,
                ),
                height: 150,
                alignment: Alignment(0, 0),
                child:
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(52, 58, 64, 1.0),
                    ),
                    height: 150,
                    child: ListTile(
                      key: UniqueKey(),
                      title: Text(computer.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white), textAlign: TextAlign.center,),
                      subtitle: Text(computer.updateDateF, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                      trailing: CircleAvatar(
                        child: Text(computer.software.length.toString(), style: TextStyle(color: Color.fromRGBO(52, 58, 64, 1.0),),),
  //                      foregroundColor: Colors.black,
  //                      backgroundColor: Colors.black12,
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SoftwareList(
                              title: computer.name,
                              software: computer.software,
                            )
                          )
                        );
                      },
                    ),
                  ),
              );
            }).toList()
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: null,
      ),
    );
  }


//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        body: Container(
//          child: ListView.builder(
//            itemCount: computers.length,
//            itemBuilder: (context, index){
//              return Card(
//                color: Colors.grey,
//                key: UniqueKey(),
//                elevation: 1.0,
//                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                child: Container(
//                  key: UniqueKey(),
//                  decoration: BoxDecoration(color: Colors.black12,),
//                  child: ListTile(
//                    key: UniqueKey(),
//                    title: Text(computers.elementAt(index).name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
//                    subtitle: Text(computers.elementAt(index).updateDateF, style: TextStyle(color: Colors.white),),
//                    trailing: CircleAvatar(
//                      child: Text(computers.elementAt(index).software.length.toString(), style: TextStyle(color: Colors.grey),),
////                      foregroundColor: Colors.black,
////                      backgroundColor: Colors.black12,
//                    ),
//                    onTap: (){
//                      Navigator.of(context).push(
//                        MaterialPageRoute(
//                          builder: (context) => SoftwareList(
//                            title: computers.elementAt(index).name,
//                            software: computers.elementAt(index).software,
//                          )
//                        )
//                      );
//                    },
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//        floatingActionButton: null,
//      ),
//    );
//  }

  FloatingActionButton refreshFAB() {
    return FloatingActionButton(
      onPressed: () => _refresh(),
      tooltip: 'Refresh',
      child: Icon(Icons.refresh),
      elevation: 2.0,
    );
  }

  _refresh() {
//    if(sheetsData != null) sheetsData.clear();
    if(computers != null) computers.clear();
    if(values != null) values.clear();
    _load();
  }

}
