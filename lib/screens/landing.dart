import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/screens/auth.dart';
import 'package:softwareviewer/screens/home.dart';
import 'package:softwareviewer/services/access.dart';

class LandingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isAuthorized = user != null;

    return isAuthorized ? HomePage() : AuthorizationPage();
  }

}