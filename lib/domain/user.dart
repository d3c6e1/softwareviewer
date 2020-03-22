import 'package:firebase_auth/firebase_auth.dart';

class User{
  String id;
  String name;
  String email;
  String imageUrl;

  User.fromFirebase(FirebaseUser user){
    id = user.uid;
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;
  }
}
