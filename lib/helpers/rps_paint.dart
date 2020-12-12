import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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
