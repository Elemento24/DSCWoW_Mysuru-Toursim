import 'package:flutter/material.dart';

class Review {
  String author;
  String message;
  double rating;

  Review(
      {@required this.author,
      @required this.message,
      @required this.rating});
}
