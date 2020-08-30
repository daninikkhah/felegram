import 'package:flutter/material.dart';
import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  void _submitAuthentication(
      {String email, String username, String password, bool isLoginMode}) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthenticationForm(_submitAuthentication),
    );
  }
}
