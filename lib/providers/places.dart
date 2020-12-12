// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysuru_toursim/models/review.dart';
// import 'package:http/http.dart' as http;

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [
    Place(
      id: DateTime.now().toIso8601String(),
      title: 'The Temple',
      address: 'Pranshu Ka Ghar, 4220011',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed hendrerit tincidunt porta. Cras nec luctus diam. Phasellus iaculis diam vel dui rutrum, eget ullamcorper lectus commodo. Sed mollis aliquet lacus ut auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus',
      imageUrl:
          'https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/08/10/Photos/mys-kPGB--621x414@LiveMint.jpg',
      placeReview: [
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
      ],
      bestTimeToVisit: 'Evening',
    ),
    Place(
      id: DateTime.now().toIso8601String(),
      title: 'The Canyon',
      address: 'Vishesh Ka Ghar,200019',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed hendrerit tincidunt porta. Cras nec luctus diam. Phasellus iaculis diam vel dui rutrum, eget ullamcorper lectus commodo. Sed mollis aliquet lacus ut auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus',
      imageUrl:
          'https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/08/10/Photos/mys-kPGB--621x414@LiveMint.jpg',
      placeReview: [
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
        Review(
          author: 'Avneesh Kumar',
          message:
              'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
          rating: 4.9,
        ),
      ],
      bestTimeToVisit: 'Afternoon',
    ),
  ];

  List<Place> get places {
    return [..._places];
  }

  Place findById(String id) {
    return _places.firstWhere((el) => el.id == id);
  }

  void addReview({String id, String desc, double rating, String author}) {
    print(id);
    print(desc);
    print(author);
    print(rating);
  }
}
