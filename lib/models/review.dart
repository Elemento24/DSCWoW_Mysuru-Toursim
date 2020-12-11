import 'package:flutter/material.dart';

class Review {
  String userName;
  String userMessage;
  double userRating;

  Review(
      {@required this.userName,
      @required this.userMessage,
      @required this.userRating});
}
