
import 'package:flutter/material.dart';
import 'package:softwareviewer/domain/computer.dart';
import 'package:softwareviewer/screens/software.dart';

class ComputersList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ComputersListState();
}

class ComputersListState extends State<ComputersList>{

  final computers = <Computer>[
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft4':'ver1','soft2':'ver2','soft3':'ver3', }),
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft7':'ver1','soft2':'ver2','soft3':'ver3', }),
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft6':'ver1','soft4':'ver2','soft3':'ver3', }),
    Computer(name: 'comp1', updateDate: DateTime.fromMillisecondsSinceEpoch(1584466718*1000), software: {'soft9':'ver1','soft2':'ver2','soft3':'ver3', }),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
