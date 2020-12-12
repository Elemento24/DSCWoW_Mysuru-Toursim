import 'package:flutter/material.dart';
import 'package:mysuru_toursim/widgets/divider_custom.dart';
import 'package:mysuru_toursim/widgets/review_card.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: place.placeReview.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: Image.network(
                            place.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DividerCustom(),
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
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.watch_sharp),
                              Text(
                                "${place.bestTimeToVisit}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        ),
                        DividerCustom(),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            place.description,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  }
                  return ReviewCard(
                    message: place.placeReview[i - 1].message,
                    author: place.placeReview[i - 1].author,
                    rating: place.placeReview[i - 1].rating,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: Icon(Icons.rate_review)),
    );
  }
}
