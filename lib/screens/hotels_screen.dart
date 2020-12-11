import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './hotel_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hotel_card.dart';
import '../providers/hotels.dart';

class HotelsScreen extends StatelessWidget {
  static const routeName = '/hotels';

  @override
  Widget build(BuildContext context) {
    final hotels = Provider.of<Hotels>(context).hotels;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels Screen'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: hotels
              .map(
                (el) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(HotelScreen.routeName, arguments: el.id);
                  },
                  child: HotelCard(el.hotelName, el.imgUrl, el.rating),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
