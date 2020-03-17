import 'package:flutter/material.dart';
import 'package:softwareviewer/interface/landing.dart';

void main() => runApp(SoftwareViewer());

class SoftwareViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Viewer',
      theme: ThemeData(
        primaryColor: Colors.green,
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
      ),
      home: LandingPage(),
    );
  }
}
