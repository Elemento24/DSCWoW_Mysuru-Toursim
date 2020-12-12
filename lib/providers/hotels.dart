import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/review.dart';
import '../models/hotel.dart';

class Hotels with ChangeNotifier {
  List<Hotel> _hotels = [
    // Hotel(
    //     id: DateTime.now().toIso8601String(),
    //     imgUrl:
    //         'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
    //     rating: '5.0',
    //     hotelName: 'The Grand Hotel',
    //     hotelAddress: 'B-27, First Street, Mysuru',
    //     hotelContactNumber: '+91 61278 12712',
    //     hotelEstimatedRoomPrices: '4000',
    //     hotelGmailLink: 'thegrandhotel@email.com',
    //     hotelWebsiteLink: 'http://thegrandhotel.com',
    //     hotelReviews: [
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //     ]),
    // Hotel(
    //     id: DateTime.now().toIso8601String(),
    //     imgUrl:
    //         'https://i.pinimg.com/originals/56/e9/9f/56e99f9882a649e88f8ea54d2a8bd1ab.jpg',
    //     rating: '4.0',
    //     hotelName: 'The Empire Hotel',
    //     hotelAddress: 'B-27, First Street, Mysuru',
    //     hotelContactNumber: '+91 61278 12712',
    //     hotelEstimatedRoomPrices: '5000',
    //     hotelGmailLink: 'theempirehotel@email.com',
    //     hotelWebsiteLink: 'http://theempire.hotel',
    //     hotelReviews: [
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //       Review(
    //         rating: 4.5,
    //         author: 'Vishesh',
    //         message:
    //             'Excellent hotel with excellent location located at the city center,extremely clean & comfortable . Upon arrival we were warmly welcomed by the friendly reception staff Ildiko ,',
    //       ),
    //     ]),
  ];
  final String userId;
  // final String authToken;

  Hotels(this.userId, this._hotels);

  List<Hotel> get hotels {
    return [..._hotels];
  }

  Hotel findById(String id) {
    return _hotels.firstWhere((el) => el.id == id);
  }

  void addReview({
    String id,
    String desc,
    double rating,
    String author,
  }) async {
    final url =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/hotels/$id/reviews.json';
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

      final hotel = _hotels.firstWhere((el) => el.id == id);
      hotel.reviews.add(newReview);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetHotels() async {
    final url =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/hotels.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      final List<Hotel> loadedHotels = [];
      final List<Review> reviews = [];
      Review review;
      extractedData.forEach((hotelId, data) {
        if (data['reviews'].length > 0) {
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
        loadedHotels.add(
          Hotel(
            id: hotelId,
            hotelName: data['title'],
            hotelAddress: data['address'],
            hotelContactNumber: data['hotelContactNumber'],
            imgUrl: data['imgUrl'],
            rating: data['rating'],
            reviews: reviews,
          ),
        );
      });
      _hotels = loadedHotels;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
