import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  static const padding_lr = 20.0;
  static const padding_top = 12.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Login',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: null,
            child: Text(
              "Sign Up",
              style: TextStyle(fontSize: 12, color: Colors.brown),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Icon(
                Icons.account_circle,
                size: 80,
              ),
              alignment: Alignment.topCenter,
            ),
            Flex(
              direction: Axis.vertical,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: padding_top, left: padding_lr, right: padding_lr),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: padding_top, left: padding_lr, right: padding_lr),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2 * padding_top,
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              label: Text("Login"),
              icon: Icon(Icons.login),
              heroTag: null,
              elevation: 2,
            ),
            FlatButton(
              child: Text("Continue as Visitor"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
