import 'package:flutter/material.dart';

import './signup_screen.dart';

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
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
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
            Container(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Log In', style: TextStyle(color: Colors.black)),
              icon: Icon(Icons.login, color: Colors.black),
              heroTag: null,
              elevation: 2,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
