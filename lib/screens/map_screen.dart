import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Map Screen'),
      ),
    );
  }
}
