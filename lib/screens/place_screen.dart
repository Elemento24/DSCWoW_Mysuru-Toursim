import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/place';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final place = Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Text(place.title),
      ),
    );
  }
}
