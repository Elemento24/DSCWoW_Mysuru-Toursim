import 'package:flutter/material.dart';

import '../screens/vol_screen.dart';
import './divider_custom.dart';

class VolunteerCard extends StatelessWidget {
  final String title, phoneNumber, description, volId;

  VolunteerCard(this.title, this.phoneNumber, this.description, this.volId);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(VolunteerScreen.routeName, arguments: volId);
        },
        child: Card(
            color: Colors.amber[50],
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: DividerCustom()),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
