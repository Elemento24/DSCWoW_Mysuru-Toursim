import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hotels.dart';

class HotelScreen extends StatelessWidget {
  static const routeName = '/hotel';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final hotel = Provider.of<Hotels>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
      ),
      body: Center(
        child: Text(hotel.hotelName),
      ),
    );
  }
}
