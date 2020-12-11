import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

class Hotel {
  final String id;
  final String hotelName;
  final String hotelAddress;
  final String hotelContactNumber;
  final String hotelGmailLink;
  final String hotelWebsiteLink;
  final String hotelEstimatedRoomPrizes;
  final List<Review> hotelReviews;

  Hotel(
      {@required this.id,
      @required this.hotelName,
      @required this.hotelAddress,
      @required this.hotelContactNumber,
      this.hotelGmailLink,
      this.hotelWebsiteLink,
      this.hotelEstimatedRoomPrizes,
      @required this.hotelReviews});
}
