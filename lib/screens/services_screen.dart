import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Services Screen'),
      ),
    );
  }
}
