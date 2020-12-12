import 'package:flutter/material.dart';

import './login_screen.dart';
import '../widgets/signup_card.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mysuru Tourism'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Text('Login', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
      body: SignupCard(),
    );
  }
}
