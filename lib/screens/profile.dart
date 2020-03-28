import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/screens/auth.dart';
import 'package:softwareviewer/services/access.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.deepPurpleAccent[200], Colors.purple[300]],
          ),
        ),
        child: Center(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 40,),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                user.name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                user.email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  AccessService().signOutGoogle();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {return AuthorizationPage();}));
                },
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.purple,),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}