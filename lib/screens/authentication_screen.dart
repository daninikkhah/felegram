import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          ? await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trimRight(), password: password.trimRight())
          : await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trimRight(), password: password.trimRight());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'an error occurred, please check your credentials.';
      if (e.message != null) errorMessage = e.message;

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: _initializeFirebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('something went wrong!');
            if (snapshot.connectionState == ConnectionState.done)
              return AuthenticationForm(_submitAuthentication);
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
