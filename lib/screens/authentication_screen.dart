import 'package:flutter/material.dart';
import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthenticationForm(),
    );
  }
}
