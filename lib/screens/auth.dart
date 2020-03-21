import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:softwareviewer/screens/home.dart';
import 'package:softwareviewer/screens/landing.dart';
import 'package:softwareviewer/services/auth.dart';

class AuthorizationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>{
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

    Widget _signInButton() {
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
            children: <Widget>[
              Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Log in with Google',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20),
                ),
              )
            ],
          ),
        ),
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                }
              )
            );
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          SizedBox(height: 100,),
          _signInButton(),
        ],
      ),
    );
  }
}
