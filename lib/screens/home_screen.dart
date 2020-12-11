import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mysuru: One of it\'s Kind'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage('assets/images/1.webp'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mysore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'The Cultural Capital of Karnataka',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              // height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: .5,
                  colors: [
                    Colors.white,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'About Mysore',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'The cultural ambiance and achievements of Mysuru earned it the sobriquet Cultural Capital of Karnataka. Mysuru is noted for its heritage structures and palaces, including the Mysuru Palace, and for the festivities that take place during the Dasara festival when the city receives many tourists from around the world.',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/2.jpeg'),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                      Image(
                        image: AssetImage('assets/images/3.jpeg'),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                      Image(
                        image: AssetImage('assets/images/4.jpeg'),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}
