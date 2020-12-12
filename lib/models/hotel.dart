import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

class Hotel {
  final String id;
  final String imgUrl;
  final String rating;
  final String hotelName;
  final String hotelAddress;
  final String hotelContactNumber;
  final String hotelGmailLink;
  final String hotelWebsiteLink;
  final String hotelEstimatedRoomPrices;
  final List<Review> reviews;

  Hotel({
    @required this.id,
    @required this.imgUrl,
    @required this.rating,
    @required this.hotelName,
    @required this.hotelAddress,
    @required this.hotelContactNumber,
    @required this.hotelEstimatedRoomPrices,
    this.hotelGmailLink,
    this.hotelWebsiteLink,
    this.reviews,
  });
}
