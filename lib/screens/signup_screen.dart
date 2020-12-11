import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-Up Screen'),
      ),
      body: Center(
        child: Text('Sign-Up Screen'),
      ),
    );
  }
}
