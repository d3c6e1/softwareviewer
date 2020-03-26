import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/screens/home.dart';
import 'package:softwareviewer/services/access.dart';

class AuthorizationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AuthorizationPageState();
}

class AuthorizationPageState extends State<AuthorizationPage>{

  AccessService authService = AccessService();

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Container(
            child: Align(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                  ),
                  children: [
                    TextSpan(text: 'SOFTWARE ',),
                    TextSpan(text: 'VIEWER',),
                  ]
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _button(List<Widget> text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightColor: Colors.white70,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: text,
          ),
        ),
        onPressed: () {
          func();
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          SizedBox(height: 200,),
          _button(_logInText(context), () => _logIn(context)),
        ],
      ),
    );
  }

  void _logIn(BuildContext context) {
    authService.signInWithGoogle().whenComplete(() {
      final User user = Provider.of<User>(context, listen: false);
      final bool isAuthorized = user != null;

      if (isAuthorized){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => HomePage()
            )
        );
      }
    });
  }

  List<Widget> _logInText(BuildContext context) {
    return <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Open with Google',
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20),
              ),
            )
          ];
  }
}
