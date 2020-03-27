
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
  List<Sheet> sheets;


  _load() async {
    authService.connect().then((spreadSheet) => sheets = spreadSheet.sheets).whenComplete(() {
      setState(() {
        sheets.forEach((sheet) {
          var t = BatchGetValuesByDataFilterRequest.fromJson({
            'dataFilters': [
              'a1Range',
            ]
          });
          print(sheet);
          computers.add(Computer(name: sheet.properties.title.toString(), updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft4':'ver1','soft2':'ver2','soft3':'ver3', }));

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
    if(sheets != null) sheets.clear();
    if(computers != null) computers.clear();
    _load();
  }

}
