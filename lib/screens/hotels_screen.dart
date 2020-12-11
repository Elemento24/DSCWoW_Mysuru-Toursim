import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/hotel_card.dart';

class HotelsScreen extends StatelessWidget {
  static const routeName = '/hotels';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels Screen'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HotelCard(
              'Hotel Grand',
              'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
              '5.0',
            ),
            HotelCard(
              'Hotel Empire',
              'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
              '4.0',
            ),
          ],
        ),
      ),
    );
  }
}

// 'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg'
