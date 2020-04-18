import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/screens/auth.dart';
import 'package:softwareviewer/services/access.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {


  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Scaffold(
        body: Center(
          child: Column(
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
                user.name,
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(52, 58, 64, 1.0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                user.email,
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(52, 58, 64, 1.0),
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromRGBO(52, 58, 64, 1.0),),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ],
          ),
        ),
    );
  }
}