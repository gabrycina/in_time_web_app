import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_web/material.dart';
import 'package:flutter_web/cupertino.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = fb.auth();
  var provider = fb.GoogleAuthProvider();
  var loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CupertinoButton(
              color: CupertinoColors.activeGreen,
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                    color: CupertinoColors.white,
                    fontFamily: 'Helvetica',
                    fontSize: 15,
                ),
              ),
              onPressed: () async {
                loggedUser = await googleSignIn();
                if (loggedUser != null) {
                  Navigator.pop(context, loggedUser);
                } else {
                  fb.auth().currentUser.delete();
                  Navigator.pop(context, null);
                }
              }),
        ),
      ),
    );
  }

  Future<fb.UserCredential> googleSignIn() async {
    fb.UserCredential user;
    var selectedPersistence = 'local';
    await auth.setPersistence(selectedPersistence);
    try{
      user = await auth.signInWithPopup(provider);
    }catch(e){
      print(e);
    }
    return user;
  }

}
