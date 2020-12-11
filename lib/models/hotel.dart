import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

class Hotel {
  String hotelName;
  String hotelAddress;
  String hotelContactNumber;
  String hotelGmailLink;
  String hotelWebsiteLink;
  String hotelEstimatedRoomPrizes;
  List<Review> hotelReviews;

  Hotel(
      {@required this.hotelName,
      @required this.hotelAddress,
      @required this.hotelContactNumber,
      this.hotelGmailLink,
      this.hotelWebsiteLink,
      this.hotelEstimatedRoomPrizes,
      @required this.hotelReviews});
}
