import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  FirebaseAuth _firebaseAuth;

  final Future<FirebaseApp> _initializeFirebaseApp = Firebase.initializeApp();

  void _submitAuthentication(
      {BuildContext context,
      String email,
      String username,
      String password,
      bool isLoginMode}) async {
    _firebaseAuth = FirebaseAuth.instance;

    try {
      isLoginMode
          ? _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password)
          : _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
    } on PlatformException catch (e) {
      // TODO
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFirebaseApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: AuthenticationForm(_submitAuthentication),
            );
          }
          return Text('data'); //todo implement error handling
        });
  }
}
