import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
//            width: 300,
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
                    TextSpan(
                      text: 'SOFTWARE ',
                    ),
                    TextSpan(
                      text: 'VIEWER',
//                      style: TextStyle(fontSize: 80),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _button(String text, func()){
      return  RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Colors.white70,
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 21),
        ),
        onPressed: () => func,
      );
    }

    Widget _auth(String text, func()){
      return Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                _button(text, () => func),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          _auth('GOOGLE authorization', (){}),
        ],
      ),
    );
  }
}
