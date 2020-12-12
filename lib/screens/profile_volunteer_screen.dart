import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:mysuru_toursim/widgets/review_card.dart';

class ProfileVolunteerScreen extends StatefulWidget {
  @override
  _ProfileVolunteerScreenState createState() => _ProfileVolunteerScreenState();
}

class _ProfileVolunteerScreenState extends State<ProfileVolunteerScreen> {
  // below are some dummy variables for review card
  final String message =
      'Quando ambulabat agendis admonere te qualis actio. Si ad corpus, quae plerumque Imaginare tecum in balineo quidam aquam';
  final String author = 'Avneesh Kumar';
  final double rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context)
                        .size
                        .height), //You can Replace this with your desired WIDTH and HEIGHT
                painter: RPSCustomPainter(),
              ),
              Column(
                children: [
                  Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width / 3,
                  ),
                  ListTile(
                    title: Text("Anuj Verma", textAlign: TextAlign.center),
                    subtitle: Text(
                      "+91 8098098090",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ReviewCard(message: message, author: author, rating: rating),
                  ReviewCard(message: message, author: author, rating: rating),
                  ReviewCard(message: message, author: author, rating: rating)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, 0),
        Offset(size.width, size.height * 0.30),
        [Color(0xfffda005), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(size.width * -0.01, size.height * 0.30,
        size.width * 0.50, size.height * 0.30);
    path_0.quadraticBezierTo(
        size.width * 0.98, size.height * 0.30, size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
