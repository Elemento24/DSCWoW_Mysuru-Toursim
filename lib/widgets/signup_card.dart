import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({
    Key key,
  }) : super(key: key);

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _lastNameFN = FocusNode();
  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _confirmPasswordFN = FocusNode();
  Map<String, Object> _authData = {
    'email': '',
    'password': '',
    'firstName': '',
    'lastName': '',
    'isTourist': true,
  };

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _lastNameFN.dispose();
    _emailFN.dispose();
    _passwordFN.dispose();
    _confirmPasswordFN.dispose();
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
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
        _authData['firstName'],
        _authData['lastName'],
        _authData['isTourist'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      print(error);

      if (error.toString().contains('EMAIL_EXISTS'))
        errorMessage = 'This Email Address is already in use!';
      else if (error.toString().contains('INVALID_EMAIL'))
        errorMessage = 'This is not a Valid Email Address';
      else if (error.toString().contains('WEAK_PASSWORD'))
        errorMessage = 'This Password is too weak!';
      else if (error.toString().contains('INVALID_PASSWORD'))
        errorMessage = 'Invalid Password!';

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not Sign you up. Please try again later!';
      _showErrorDialog(errorMessage);
    }

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
                color: Colors.black,
              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter your First Name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastNameFN);
                    },
                    onSaved: (value) {
                      _authData['firstName'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: _lastNameFN,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter your Last Name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFN);
                    },
                    onSaved: (value) {
                      _authData['lastName'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFN,
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
                    controller: _passwordController,
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
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_confirmPasswordFN);
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _confirmPasswordFN,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not Match!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SwitchListTile(
                    title: _authData['isTourist']
                        ? Text(
                            'Tourist',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Text(
                            'Volunteer',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                    value: _authData['isTourist'],
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (arg) {
                      setState(() {
                        _authData['isTourist'] = arg;
                      });
                    },
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: _submit,
                          label: Text('Sign Up',
                              style: TextStyle(color: Colors.black)),
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
