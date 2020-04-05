import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
//          child: ,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: searchFAB(),
      ),
    );
  }

  FloatingActionButton searchFAB() {
    return FloatingActionButton(
      onPressed: () => null,
      tooltip: 'Refresh',
      child: Icon(Icons.search, color: Colors.white,),
      elevation: 2.0,
    );
  }

}