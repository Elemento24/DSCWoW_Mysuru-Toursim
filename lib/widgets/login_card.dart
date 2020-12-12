import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    Key key,
  }) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordFN = FocusNode();
  var _isError = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    super.dispose();
    _passwordFN.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error occured'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
      _isError = false;
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      _isError = true;

      if (error.toString().contains('INVALID_EMAIL'))
        errorMessage = 'This is not a Valid Email Address';
      else if (error.toString().contains('WEAK_PASSWORD'))
        errorMessage = 'This Password is too weak!';
      else if (error.toString().contains('EMAIL_NOT_FOUND'))
        errorMessage = 'Could not find a User with that Email!';
      else if (error.toString().contains('INVALID_PASSWORD'))
        errorMessage = 'Invalid Password!';

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not Authenticate You. Please try again later!';
      _isError = true;
      _showErrorDialog(errorMessage);
    }

    // Quick Fix
    if (!_isError) Navigator.of(context).pushReplacementNamed('/');

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Icon(
                Icons.account_circle,
                size: 80,
              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFN);
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFN,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: _submit,
                          label: Text(
                            'Log In',
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.login, color: Colors.black),
                          heroTag: null,
                          elevation: 2,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
