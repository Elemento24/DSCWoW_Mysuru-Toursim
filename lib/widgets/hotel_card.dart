import 'package:flutter/material.dart';

import '../models/hotel.dart';

class HotelCard extends StatelessWidget {
  final int selectCorner;
  final Hotel hotelItem;

  HotelCard({@required this.selectCorner, this.hotelItem});

  ShapeBorder selectBorderCorner() {
    if (selectCorner == 0) {
      print(true);
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)));
    } else
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)));
  }

  @override
  Widget build(BuildContext context) {
    print(selectCorner);
    double cardHeigh = MediaQuery.of(context).size.height * 0.3;
    double cardWidth = cardHeigh * 2;
    return Container(
      padding: EdgeInsets.all(10),
      height: cardHeigh,
      width: cardWidth,
      child: Card(
        shape: selectBorderCorner(),
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Container(
                child: Image.network(
                  'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
                  fit: BoxFit.fill,
                ),
              ),
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
            Container(
              width: double.infinity,
              height: cardHeigh * 0.2,
              color: Colors.white,
              margin: EdgeInsets.only(top: cardHeigh * 0.69),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Hotel Dummy 1",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: cardHeigh * 0.2,
                    width: cardWidth * 0.3,
                  ),
                  Text(
                    "5.0",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg'
