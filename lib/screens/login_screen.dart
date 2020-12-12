import 'package:flutter/material.dart';

import './signup_screen.dart';
import '../widgets/login_card.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mysuru Tourism'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(SignupScreen.routeName);
            },
            child: Text('Sign Up', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
      body: LoginCard(),
    );
  }
}
