import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  static const routeName = '/place';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Screen'),
      ),
      body: Center(
        child: Text('Places Screen'),
      ),
    );
  }
}
