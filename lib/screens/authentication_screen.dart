import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  FirebaseAuth _firebaseAuth;
  bool _isLoading = false;

  void _submitAuthentication(
      {BuildContext context,
      String email,
      String username,
      String password,
      bool isLoginMode}) async {
    _firebaseAuth = FirebaseAuth.instance;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoginMode) {
        final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email.trimRight(), password: password.trimRight());
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
        });
      } else
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trimRight(), password: password.trimRight());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'an error occurred, please check your credentials.';
      if (e.message != null) errorMessage = e.message;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthenticationForm(_submitAuthentication, _isLoading),
    );
  }
}
