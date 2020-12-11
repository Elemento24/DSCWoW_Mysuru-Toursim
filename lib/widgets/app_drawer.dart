import 'package:flutter/material.dart';

import '../screens/places_screen.dart';
import '../screens/hotels_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext ctx, String title, IconData icon, String route) {
    return ListTile(
      tileColor: Colors.amber[100],
      leading: Icon(
        icon,
        size: 30,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pushReplacementNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Image(
              image: AssetImage('assets/images/0.png'),
              // fit: BoxFit.cover,
              height: 150,
              width: 75,
            ),
          ),
          SizedBox(height: 20),
          buildListTile(context, 'Home', Icons.home, '/'),
          SizedBox(height: 20),
          buildListTile(
              context, 'Touristic Places', Icons.place, PlacesScreen.routeName),
          SizedBox(height: 20),
          buildListTile(
              context, 'Places to Stay', Icons.hotel, HotelsScreen.routeName),
        ],
      ),
    );
  }
}
