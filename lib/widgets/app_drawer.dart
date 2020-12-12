import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/places_screen.dart';
import '../screens/hotels_screen.dart';
import '../screens/services_screen.dart';
import '../screens/map_screen.dart';
import '../screens/create_profile_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext ctx, String title, IconData icon, String route) {
    return ListTile(
      tileColor: Colors.amber[100],
      leading: Icon(
        icon,
        size: 20,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
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
    final isTourist = Provider.of<Auth>(context).isTourist;
    final hasCreatedProfile = Provider.of<Auth>(context).hasCreatedProfile;
    final profileSec = isTourist
        ? [SizedBox(height: 0)]
        : [
            SizedBox(height: 10),
            hasCreatedProfile
                ? buildListTile(context, 'Edit Profile', Icons.person,
                    EditProfileScreen.routeName)
                : buildListTile(context, 'Create Profile', Icons.person,
                    CreateProfileScreen.routeName),
          ];

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Image(
              image: AssetImage('assets/images/0.png'),
              // fit: BoxFit.cover,
              height: 150,
              width: 75,
            ),
          ),
          SizedBox(height: 10),
          buildListTile(context, 'Home', Icons.home, '/'),
          SizedBox(height: 10),
          buildListTile(
              context, 'Touristic Spots', Icons.place, PlacesScreen.routeName),
          SizedBox(height: 10),
          buildListTile(context, 'Hotels', Icons.hotel, HotelsScreen.routeName),
          SizedBox(height: 10),
          buildListTile(context, 'Services', Icons.miscellaneous_services,
              ServicesScreen.routeName),
          SizedBox(height: 10),
          buildListTile(context, 'Map', Icons.map, MapScreen.routeName),
          ...profileSec,
          SizedBox(height: 10),
          ListTile(
            tileColor: Colors.amber[100],
            leading: Icon(
              Icons.exit_to_app,
              size: 20,
              color: Colors.black,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
