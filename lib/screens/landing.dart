import 'package:flutter/widgets.dart';
import 'package:softwareviewer/screens/auth.dart';
import 'package:softwareviewer/screens/home.dart';

class LandingPage extends StatelessWidget{
//  bool isAuthorized;
//  LandingPage(@required this.isAuthorized);

  @override
  Widget build(BuildContext context) {
    final bool isAuthorized = false;
    return isAuthorized ? HomePage() : AuthorizationPage();
  }

}