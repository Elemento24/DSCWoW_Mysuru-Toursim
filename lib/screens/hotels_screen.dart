import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../models/hotel.dart';
import '../widgets/hotel_card.dart';

class HotelsScreen extends StatelessWidget {
  static const routeName = '/hotels';
  List<Hotel> hotelsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels Screen'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          HotelCard(selectCorner: 1),
          HotelCard(selectCorner: 0)
        ],
      ),
    );
  }
}
