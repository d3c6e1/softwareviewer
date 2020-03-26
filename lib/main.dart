import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softwareviewer/screens/landing.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/services/access.dart';

void main() => runApp(SoftwareViewer());

class SoftwareViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AccessService().currentUser,
      child: MaterialApp(
        title: 'Software Viewer',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
        ),
        home: LandingPage(),
      ),
    );
  }
}
