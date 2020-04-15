import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:softwareviewer/domain/computer.dart';

class SoftwareList extends StatelessWidget{
  final String title;
  final List<Software> software;

  SoftwareList({Key key, @required this.title, @required this.software}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(52, 58, 64, 1.0),
          brightness: Brightness.dark,
          title: Text(title, style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: CircleAvatar(child: Text(software.length.toString(), style: TextStyle(fontWeight: FontWeight.bold),),), onPressed: null),
//            IconButton(
//                icon: Icon(Icons.search, color: Colors.white,),
//                onPressed: null,
//            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: software.length,
            itemBuilder: (context, index) {
              return  ListTile(
                title: Text(software.elementAt(index).appName, overflow: TextOverflow.ellipsis,),
                subtitle: Text(software.elementAt(index).appVersion, overflow: TextOverflow.ellipsis,),
              );
            }
          ),
        ),
      ),
    );
  }
}