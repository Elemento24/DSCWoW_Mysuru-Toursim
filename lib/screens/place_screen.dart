import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/place';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final place = Provider.of<Places>(context, listen: false).findById(id);
    final Widget customDivider = Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        height: 4,
        thickness: 2,
        color: Colors.amber.shade300,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 30,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "${place.title}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            customDivider,
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                  Text(
                    "${place.address}",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Best Time To Visit : ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "${place.bestTimeToVisit}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            customDivider,
            Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  place.description,
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
