import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:softwareviewer/domain/user.dart';
import 'package:softwareviewer/services/client.dart';


 class AccessService {
   final GoogleSignIn _googleSignIn = GoogleSignIn(
       scopes: <String>[
         SheetsApi.SpreadsheetsReadonlyScope
       ]
   );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String spreadsheetId = '1LrsHlVFmjkWU3vV6HOH1cj25jsxAUyUYYCZ-wNPoeD8';

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await  _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return User.fromFirebase(user);
  }

  Future signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print("User Sign Out");
  }

  Stream<User> get currentUser {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => user != null ? User.fromFirebase(user) : null);
  }

  Future<SheetsApi> get sheetsApi async {
    final GoogleSignInAccount googleSignInAccount = await  _googleSignIn.signInSilently();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final client = GoogleAuthClient(
        defaultHeaders: {
          'Authorization' : 'Bearer ${googleSignInAuthentication.accessToken}'
        }
    );

    return SheetsApi(client);
  }

  Future<Spreadsheet> get spreadSheet async {
    return await sheetsApi.then((api) => api.spreadsheets.get(spreadsheetId));
  }

  Future<SpreadsheetsValuesResourceApi> get values async {
    return await sheetsApi.then((api) => api.spreadsheets.values);
  }

  Future<ValueRange> sheetValues(String range) async {
    return await values.then((values) => values.get(spreadsheetId, range));
  }
 }