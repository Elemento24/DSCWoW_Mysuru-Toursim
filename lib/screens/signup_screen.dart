import 'package:flutter/material.dart';

import './login_screen.dart';
import '../widgets/signup_card.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(left: 16),
          child: Image(
            image: AssetImage('assets/images/0.png'),
          ),
        ),
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
