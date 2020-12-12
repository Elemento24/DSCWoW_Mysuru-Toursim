import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/volunteer.dart';

class Volunteers with ChangeNotifier {
  List<Volunteer> _volunteers = [];
  final String userId;
  final String name;
  final bool hasCreatedProfile;
  // final String authToken;

  Volunteers(this.userId, this.name, this.hasCreatedProfile, this._volunteers);

  List<Volunteer> get volunteers {
    return [..._volunteers];
  }

  Volunteer findById(String id) {
    return _volunteers.firstWhere((el) => el.id == id);
  }

  Future<void> addVolunteer({
    String title,
    String description,
    String phone,
    bool isCab,
  }) async {
    final url =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/volunteers.json';
    final userUrl =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/users/$userId.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'userId': userId,
          'name': name,
          'title': title,
          'description': description,
          'phone': phone,
          'isCab': isCab,
          'reviews': [],
        }),
      );

      await http.patch(
        userUrl,
        body: json.encode({
          'hasCreatedProfile': true,
        }),
      );

      final newVolunteer = Volunteer(
        id: json.decode(response.body)['name'],
        userId: userId,
        name: name,
        title: title,
        description: description,
        phone: phone,
        isCab: isCab,
      );
      _volunteers.add(newVolunteer);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
