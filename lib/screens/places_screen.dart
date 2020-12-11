import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class PlacesScreen extends StatelessWidget {
  static const routeName = '/place';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Places Screen'),
      ),
    );
  }
}
