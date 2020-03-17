import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softwareviewer/logic/Computer.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            'COMPUTERS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          ),
          centerTitle: true,
          ),
        body: ComputersList(),
        ),
    );
  }
}

class ComputersList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ComputersListState();
}

class ComputersListState extends State<ComputersList>{

  final computers = <Computer>[
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft1':'ver1','soft2':'ver2','soft3':'ver3', }),
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft1':'ver1','soft2':'ver2','soft3':'ver3', }),
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft1':'ver1','soft2':'ver2','soft3':'ver3', }),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: computers.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(76, 175, 80, 0.85),
                  ),
                  child: ListTile(
                    title: Text(
                      computers.elementAt(index).name,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    subtitle: Text(
                      computers.elementAt(index).updateDateF,
                      style: TextStyle(
                          color: Colors.white70,
                      ),
                    ),
                    trailing: CircleAvatar(
                      child: Text(computers.elementAt(index).software.length.toString()),
                      backgroundColor: Colors.black45,
                    ),
                    onTap: (){

                    },
                  ),
                ),
              );
            },
        ),
      ),
    );
  }

}
