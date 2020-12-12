import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String _firstName;
  String _lastName;
  bool _isTourist;
  bool _hasCreatedProfile;

  bool get isAuth {
    return token != null;
  }

  bool get isTourist {
    return _isTourist;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get name {
    return '$_firstName $_lastName';
  }

  Future<void> _authenticate({
    @required String email,
    @required String password,
    @required String urlSegment,
    @required bool isSignup,
    String firstName = '',
    String lastName = '',
    bool isTourist = true,
  }) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${DotEnv().env["FIREBASE_KEY"]}';
    final userUrl =
        'https://mysuru-tourism-7d522-default-rtdb.firebaseio.com/users.json';
    try {
      // Authorizing with Firebase
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      // Throwing a Custom Exception in case of an Error
      final resData = json.decode(response.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }

      // Setting the Common Properties in Case of Sign Up & Login
      _token = resData['idToken'];
      _userId = resData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(resData['expiresIn']),
        ),
      );

      // Making an Entry in the User Model in case of Sign Up
      if (isSignup) {
        await http.post(
          userUrl,
          body: json.encode({
            'firstName': firstName,
            'lastName': lastName,
            'isTourist': isTourist,
            'userId': resData['localId'],
            'hasCreatedProfile': false,
          }),
        );
        _firstName = firstName;
        _lastName = lastName;
        _isTourist = isTourist;
        _hasCreatedProfile = false;
      }
      // Fetching the Data from the User Model
      else {
        final userRes =
            await http.get('$userUrl?orderBy="userId"&equalto=$_userId');
        final userData = json.decode(userRes.body) as Map;
        var userDetails = {};
        userData.forEach((key, val) => userDetails = val);
        _firstName = userDetails['firstName'];
        _lastName = userDetails['lastName'];
        _isTourist = userDetails['isTourist'];
        _hasCreatedProfile = userDetails['hasCreatedProfile'];
      }

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
        'firstName': _firstName,
        'lastName': _lastName,
        'isTourist': _isTourist,
        'hasCreatedProfile': _hasCreatedProfile,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signup(String email, String password, String firstName,
      String lastName, bool isTourist) async {
    return _authenticate(
      email: email,
      password: password,
      urlSegment: 'signUp',
      isSignup: true,
      firstName: firstName,
      lastName: lastName,
      isTourist: isTourist,
    );
  }

  Future<void> login(String email, String password) async {
    return _authenticate(
      email: email,
      password: password,
      urlSegment: 'signInWithPassword',
      isSignup: false,
    );
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _firstName = extractedUserData['firstName'];
    _lastName = extractedUserData['lastName'];
    _isTourist = extractedUserData['isTourist'];
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timetoExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoExpiry), logout);
  }
}
