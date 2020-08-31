import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  AuthenticationForm(this.submitAuthentication, this.isLoading);
  final bool isLoading;
  final void Function(
      {BuildContext context,
      String email,
      String username,
      String password,
      bool isLoginMode}) submitAuthentication;
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoginMode = false;
  String _username;
  String _email;
  String _password;

  void _changeAuthenticationState() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      widget.submitAuthentication(
        context: context,
        email: _email,
        username: _username,
        password: _password,
        isLoginMode: _isLoginMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) =>
                        (value == null) || !value.contains('@')
                            ? 'please enter a valid email address'
                            : null,
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                  ),
                  if (_isLoginMode)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) => (value == null || value.length < 4)
                          ? 'please enter a username with at least 4 letters'
                          : null,
                      onSaved: (value) => _username = value,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) => (value == null || value.length < 6)
                        ? 'please enter a password with minimum of 6 letters'
                        : null,
                    onSaved: (value) => _password = value,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: _submit,
                          child: Text(_isLoginMode ? 'Login' : 'sign in'),
                        ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: _changeAuthenticationState,
                      child: Text(_isLoginMode
                          ? 'create new account'
                          : 'already have an account'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
