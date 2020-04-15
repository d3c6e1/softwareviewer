import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:softwareviewer/domain/computer.dart';
import 'package:softwareviewer/screens/software.dart';
import 'package:softwareviewer/services/access.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>{
  AccessService authService = AccessService();
  List<Computer> computers = List<Computer>();
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

  Future<List<Computer>> search(String search) async {
    List<Computer> comps = List<Computer>();
    for(int i = 0; i < computers.length; i++){
      for(int j = 0; j < computers[i].software.length; j++) {
        if(computers[i].software[j].appName.toLowerCase().contains(search.toLowerCase())){
          comps.add(computers[i]);
          break;
        }
      }
    }
    return comps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Computer>(
            minimumChars: 3,
            onSearch: search,
            onItemFound: (Computer comp, int index){
              return Card(
                elevation: 2.0,
                color: Color.fromRGBO(52, 58, 64, 1.0),
                child: ListTile(
                  title: Text(comp.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                  subtitle: Text(comp.updateDateF, style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(),
                    ),
                    child: Text(comp.software.length.toString(), style: TextStyle(color: Color.fromRGBO(52, 58, 64, 1.0), fontSize: 35, fontWeight: FontWeight.bold),),
                  ),
                  onTap: () => _software(context, comp),

                ),
              );
            },
            loader: Text('Loading...'),
          ),
        ),
      ),
    );
  }

  void _software(BuildContext context, Computer computer) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SoftwareList(
              title: computer.name,
              software: computer.software,
            )
        )
    );
  }

  _refresh() {
    if(computers != null) computers.clear();
    if(values != null) values.clear();
    _load();
  }
}