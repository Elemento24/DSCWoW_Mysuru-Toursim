import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/review.dart';
import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [
    // Place(
    //   id: DateTime.now().toIso8601String(),
    //   title: 'The Temple',
    //   address: 'Pranshu Ka Ghar, 4220011',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed hendrerit tincidunt porta. Cras nec luctus diam. Phasellus iaculis diam vel dui rutrum, eget ullamcorper lectus commodo. Sed mollis aliquet lacus ut auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus',
    //   imageUrl:
    //       'https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/08/10/Photos/mys-kPGB--621x414@LiveMint.jpg',
    //   placeReview: [
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //   ],
    //   bestTimeToVisit: 'Evening',
    // ),
    // Place(
    //   id: DateTime.now().toIso8601String(),
    //   title: 'The Canyon',
    //   address: 'Vishesh Ka Ghar,200019',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed hendrerit tincidunt porta. Cras nec luctus diam. Phasellus iaculis diam vel dui rutrum, eget ullamcorper lectus commodo. Sed mollis aliquet lacus ut auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus',
    //   imageUrl:
    //       'https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/08/10/Photos/mys-kPGB--621x414@LiveMint.jpg',
    //   placeReview: [
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //     Review(
    //       author: 'Avneesh Kumar',
    //       message:
    //           'A great place to visit. Seems like i was in heaven. Absolutely fantastic place',
    //       rating: 4.9,
    //     ),
    //   ],
    //   bestTimeToVisit: 'Afternoon',
    // ),
  ];
  final String userId;
  // final String authToken;

  Places(this.userId, this._places);

  List<Place> get places {
    return [..._places];
  }

  Place findById(String id) {
    return _places.firstWhere((el) => el.id == id);
  }

  void addReview({
    String id,
    String desc,
    double rating,
    String author,
  }) async {
    final url =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/places/$id/reviews.json';
    try {
      // Make an Entry on the Firebase
      final response = await http.post(
        url,
        body: json.encode({
          'author': author,
          'message': desc,
          'rating': rating,
          'creatorId': userId,
        }),
      );

      // Create a local object for the new review
      final newReview = Review(
        author: author,
        message: desc,
        rating: rating,
        creatorId: userId,
        id: json.decode(response.body)['name'],
      );

      final place = _places.firstWhere((el) => el.id == id);
      place.reviews.add(newReview);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetPlaces() async {
    final url =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com//places.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      final List<Place> loadedPlaces = [];
      List<Review> reviews = [];
      Review review;
      extractedData.forEach((placeId, data) {
        if (data['reviews'].length > 0) {
          reviews = [];
          data['reviews'].forEach(
            (key, val) {
              review = Review(
                id: key,
                creatorId: val['creatorId'],
                author: val['author'],
                message: val['message'],
                rating: val['rating'],
              );
              reviews.add(review);
            },
          );
        }
        loadedPlaces.add(Place(
          id: placeId,
          address: data['address'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          title: data['title'],
          bestTimeToVisit: data['bestTimeToVisit'],
          reviews: reviews,
        ));
      });
      _places = loadedPlaces;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
