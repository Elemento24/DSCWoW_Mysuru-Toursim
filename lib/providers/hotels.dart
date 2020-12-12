// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';
// import 'package:http/http.dart' as http;

import '../models/hotel.dart';

class Hotels with ChangeNotifier {
  List<Hotel> _hotels = [
    Hotel(
        id: DateTime.now().toIso8601String(),
        imgUrl:
            'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
        rating: '5.0',
        hotelName: 'The Grand Hotel',
        hotelAddress: 'B-27, First Street, Mysuru',
        hotelContactNumber: '+91 61278 12712',
        hotelEstimatedRoomPrices: '4000',
        hotelGmailLink: 'thegrandhotel@email.com',
        hotelWebsiteLink: 'http://thegrandhotel.com',
        hotelReviews: [
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
        ]),
    Hotel(
        id: DateTime.now().toIso8601String(),
        imgUrl:
            'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
        rating: '4.0',
        hotelName: 'The Empire Hotel',
        hotelAddress: 'B-27, First Street, Mysuru',
        hotelContactNumber: '+91 61278 12712',
        hotelEstimatedRoomPrices: '5000',
        hotelGmailLink: 'theempirehotel@email.com',
        hotelWebsiteLink: 'http://theempire.hotel',
        hotelReviews: [
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
          Review(
            rating: 4.5,
            author: 'Vishesh',
            message:
                'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
          ),
        ]),
  ];

  List<Hotel> get hotels {
    return [..._hotels];
  }

  Hotel findById(String id) {
    return _hotels.firstWhere((el) => el.id == id);
  }
}
