import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services Screen'),
      ),
      body: Center(
        child: Text('Services Screen'),
      ),
    );
  }
}
