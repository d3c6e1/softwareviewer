import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
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
  List<Sheet> sheetsData;
  List<List<Object>> values;


  _load() async {
    authService.spreadSheet.then((spreadSheet) => sheetsData = spreadSheet.sheets).whenComplete(() {
      sheetsData.forEach((sheet) {
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
          child: ListView.builder(

            itemCount: computers.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black12,),
                  child: ListTile(
                    title: Text(computers.elementAt(index).name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text(computers.elementAt(index).updateDateF,),
                    trailing: CircleAvatar(
                      child: Text(computers.elementAt(index).software.length.toString()),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.black12,
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SoftwareList(
                                  title: computers.elementAt(index).name,
                                  software: computers.elementAt(index).software,
                              )
                          )
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: refreshFAB(),
      ),
    );
  }

  FloatingActionButton refreshFAB() {
    return FloatingActionButton(
      onPressed: () => _refresh(),
      tooltip: 'Refresh',
      child: Icon(Icons.refresh),
      elevation: 2.0,
    );
  }

  _refresh(){
    if(sheetsData != null) sheetsData.clear();
    if(computers != null) computers.clear();
    if(values != null) values.clear();
    _load();
  }

}
