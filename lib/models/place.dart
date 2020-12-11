import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

class Place {
  final String id;
  final String title;
  final String address;
  final String description;
  final String imageUrl;
  final String bestTimeToVisit;
  final List<Review> placeReview;

  Place({
    @required this.id,
    @required this.title,
    @required this.address,
    @required this.description,
    @required this.imageUrl,
    this.bestTimeToVisit,
    @required this.placeReview,
  });
}
