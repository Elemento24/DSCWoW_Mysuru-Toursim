import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../providers/volunteers.dart';
// import '../widgets/new_review.dart';

class VolunteerScreen extends StatelessWidget {
  static const routeName = '/volunteer';
  var _volId = '';

  @override
  Widget build(BuildContext context) {
    _volId = ModalRoute.of(context).settings.arguments as String;
    final vol = Provider.of<Volunteers>(context).findById(_volId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer'),
      ),
      body: Center(
        Text('Volunteer'),
      ),
    );
  }
}
