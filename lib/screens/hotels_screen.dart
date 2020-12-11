import 'package:flutter/material.dart';

class HotelsScreen extends StatelessWidget {
  static const routeName = '/hotels';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels Screen'),
      ),
      body: Center(
        child: Text('Hotels Screen'),
      ),
    );
  }
}
