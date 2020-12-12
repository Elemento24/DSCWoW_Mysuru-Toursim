import 'package:flutter/material.dart';

class Review {
  String id;
  String creatorId;
  String author;
  String message;
  double rating;

  Review({
    @required this.id,
    @required this.creatorId,
    @required this.author,
    @required this.message,
    @required this.rating,
  });
}
