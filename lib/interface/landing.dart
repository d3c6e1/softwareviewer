import 'package:flutter/widgets.dart';
import 'package:softwareviewer/interface/auth.dart';
import 'package:softwareviewer/interface/home.dart';

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bool isAuthorized = false;

    return isAuthorized ? HomePage() : AuthorizationPage();
  }

}