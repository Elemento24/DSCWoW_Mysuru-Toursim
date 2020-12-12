import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/edit_profile_card.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      drawer: AppDrawer(),
      body: EditProfileCard(),
    );
  }
}
