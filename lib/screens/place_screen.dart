import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/divider_custom.dart';
import '../widgets/review_card.dart';
import '../widgets/new_review.dart';
import '../providers/places.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/place';
  Places _placeProvider;
  String _placeId;

  void _addReview(String desc, double rating, String author) {
    _placeProvider.addReview(
      id: _placeId,
      author: author,
      desc: desc,
      rating: rating,
    );
  }

  void _startAddNewRev(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewReview(_addReview);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _placeId = ModalRoute.of(context).settings.arguments as String;
    final place =
        Provider.of<Places>(context, listen: false).findById(_placeId);
    _placeProvider = Provider.of<Places>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 22,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: place.reviews.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Image(
                                image: NetworkImage(place.imageUrl),
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.infinity,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DividerCustom(),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${place.address}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timelapse),
                              SizedBox(width: 10),
                              Text(
                                "${place.bestTimeToVisit}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
                          ),
                        ),
                        DividerCustom(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          child: Text(
                            place.description,
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return ReviewCard(
                    message: place.reviews[i - 1].message,
                    author: place.reviews[i - 1].author,
                    rating: place.reviews[i - 1].rating,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewRev(context),
        child: Icon(Icons.rate_review),
      ),
    );
  }
}
