import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/place_card.dart';
import '../providers/places.dart';

class PlacesScreen extends StatefulWidget {
  static const routeName = '/places';

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Places>(context).fetchAndSetPlaces().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context).places;
    return Scaffold(
      appBar: AppBar(
        title: Text('Touristic Spots'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: places
                    .map(
                      (el) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(PlaceScreen.routeName,
                              arguments: el.id);
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
