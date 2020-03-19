import 'package:flutter/material.dart';
import 'package:softwareviewer/screens/landing.dart';

void main() => runApp(SoftwareViewer());

class SoftwareViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Viewer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
      ),
      home: LandingPage(),
    );
  }
}
