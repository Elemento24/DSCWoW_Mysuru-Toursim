import 'package:flutter/material.dart';

class Place {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Place({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  });
}
