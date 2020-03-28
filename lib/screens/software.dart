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
          title: Text(title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: CircleAvatar(child: Text(software.length.toString()),), onPressed: null),
            IconButton(
                icon: Icon(Icons.search, color: Colors.white,),
                onPressed: null,
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: software.length,
            itemBuilder: (context, index) {
              return  ListTile(
                title: Text(software.elementAt(index).appName),
                subtitle: Text(software.elementAt(index).appVersion),
              );
            }
          ),
        ),
      ),
    );
  }
}