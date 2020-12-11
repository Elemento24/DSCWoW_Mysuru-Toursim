import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

enum timetoVisit { morning, afternoon, evening, lateNight }

class Place {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final timetoVisit bestTimeToVisit;
  final List<Review> placeReview;

  Place(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      this.bestTimeToVisit,
      @required this.placeReview});
}
