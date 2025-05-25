import 'dart:ui' as ui;

import 'package:api/core/designs/app_images.dart';
import 'package:flutter/material.dart';

class CustomPaintView extends StatelessWidget {
  const CustomPaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: MyPainter(),
              child: ClipOval(
                child: AppImages(
                  "https://www.jordanharbinger.com/wp-content/uploads/2018/09/be-the-most-interesting-360x360.jpg",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomPaint(
              painter: MyPainter2(),
              child: ClipPath(
                clipper: myClipper(),
                child: AppImages(
                  "https://www.jordanharbinger.com/wp-content/uploads/2018/09/be-the-most-interesting-360x360.jpg",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // path.moveTo(0, 0);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.close();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.shader = ui.Gradient.linear(
        Offset(0, size.width / 2), Offset(size.height, size.width / 2), [
      Colors.deepOrange,
      Colors.blue,
    ]);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 6;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // path.moveTo(0, 0);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.close();
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.shader = ui.Gradient.linear(
        Offset(0, size.width / 2), Offset(size.height, size.width / 2), [
      Colors.deepOrange,
      Colors.blue,
    ]);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 6;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) => true;
}
