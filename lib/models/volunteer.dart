import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';

class Volunteer {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String phone;
  final bool isCab;
  final List<Review> reviews;

  Volunteer({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.description,
    @required this.phone,
    @required this.isCab,
    this.reviews,
  });
}
