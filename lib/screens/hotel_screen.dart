import 'package:flutter/material.dart';
import 'package:mysuru_toursim/widgets/divider_custom.dart';
import 'package:mysuru_toursim/widgets/review_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/new_review.dart';
import '../providers/hotels.dart';

class HotelScreen extends StatelessWidget {
  static const routeName = '/hotel';
  Hotels _hotelProvider;
  String _hotelId;

  void _addReview(String desc, double rating, String author) {
    _hotelProvider.addReview(
      id: _hotelId,
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
    _hotelId = ModalRoute.of(context).settings.arguments as String;
    final hotel =
        Provider.of<Hotels>(context, listen: false).findById(_hotelId);
    _hotelProvider = Provider.of<Hotels>(context, listen: false);
    final BoxDecoration roundBtnBoxDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.transparent,
        style: BorderStyle.solid,
        width: 2.0,
      ),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(hotel.imgUrl),
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
              SizedBox(height: 8),
              DividerCustom(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                        Text(
                          "${hotel.hotelAddress}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade700),
                        Text('${hotel.rating}')
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: roundBtnBoxDecoration.copyWith(
                        color: Colors.green.shade100,
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            await launch('tel:${hotel.hotelContactNumber}');
                          }),
                    ),
                    Container(
                      decoration: roundBtnBoxDecoration.copyWith(
                          color: Colors.orange.shade100),
                      child: IconButton(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.orange,
                          ),
                          onPressed: () async {
                            await launch('mailto:${hotel.hotelGmailLink}');
                          }),
                    ),
                    Container(
                      decoration: roundBtnBoxDecoration.copyWith(
                          color: Colors.blue.shade100),
                      child: IconButton(
                          icon: Icon(
                            Icons.web,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            await launch('http://${hotel.hotelWebsiteLink}');
                          }),
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on_rounded),
                        Text("${hotel.hotelEstimatedRoomPrices}",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ],
                ),
              ),
              DividerCustom(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: hotel.reviews.length,
                  itemBuilder: (context, i) {
                    return ReviewCard(
                        message: hotel.reviews[i].message,
                        author: hotel.reviews[i].author,
                        rating: hotel.reviews[i].rating);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.rate_review),
        onPressed: () => _startAddNewRev(context),
      ),
    );
  }
}
