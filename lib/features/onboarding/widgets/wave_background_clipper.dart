import 'package:flutter/material.dart';

class WaveBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from the bottom-right corner
    path.moveTo(size.width, size.height);

    // Draw line to bottom-left corner
    path.lineTo(0, size.height);

    // Create the higher wave
    path.cubicTo(
      size.width * 0.1, // First control point x
      size.height * 0.80, // First control point y (adjusted higher)
      size.width * 0.3, // Second control point x
      size.height * 0.45, // Second control point y (adjusted higher)
      size.width, // End point x
      size.height * 0.6, // End point y (adjusted higher)
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

