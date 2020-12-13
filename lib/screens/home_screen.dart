import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import './hotels_screen.dart';
import './places_screen.dart';
import '../providers/volunteers.dart';
import '../providers/hotels.dart';
import '../providers/places.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Hotels>(context, listen: false).fetchAndSetHotels();
    Provider.of<Places>(context, listen: false).fetchAndSetPlaces();
    Provider.of<Volunteers>(context, listen: false)
        .fetchAndSetVolunteers()
        .then((value) {
      Provider.of<Volunteers>(context, listen: false).setDetails();
    });
  }

  Widget _buildButton(
      BuildContext context, String title, IconData icon, String route) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon),
            Text(title),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mysuru: One of it\'s Kind',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 24,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage('assets/images/1.webp'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mysore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'The Cultural Capital of Karnataka',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              // height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: .5,
                  colors: [
                    Colors.white,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'About Mysore',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'The cultural ambiance and achievements of Mysuru earned it the sobriquet Cultural Capital of Karnataka. Mysuru is noted for its heritage structures and palaces, including the Mysuru Palace, and for the festivities that take place during the Dasara festival when the city receives many tourists from around the world.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage('assets/images/2.jpeg'),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      Image(
                        image: AssetImage('assets/images/3.jpeg'),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      Image(
                        image: AssetImage('assets/images/4.jpeg'),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            _buildButton(context, 'Discover Mysore', Icons.camera,
                PlacesScreen.routeName),
            SizedBox(height: 10),
            _buildButton(
                context, 'Perfect Stay', Icons.hotel, HotelsScreen.routeName),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
