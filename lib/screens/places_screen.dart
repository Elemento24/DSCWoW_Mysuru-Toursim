import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/place_card.dart';
import '../providers/places.dart';

class PlacesScreen extends StatelessWidget {
  static const routeName = '/places';

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context).places;
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Screen'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: places
              .map(
                (el) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PlaceScreen.routeName, arguments: el.id);
                  },
                  child: PlaceCard(el.title, el.imageUrl),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
