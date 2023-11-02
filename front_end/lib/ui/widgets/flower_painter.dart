import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class FlowerPainter extends CustomPainter {
  final ui.Image flower;

  FlowerPainter({super.repaint, required this.flower});

  @override
  void paint(ui.Canvas canvas, Size size) {
    // canvas.drawCircle(Offset.zero, 100, Paint());
    // canvas.drawImage(flower, Offset.zero, Paint());
    // canvas.drawImageNine(flower, Rect.zero, Rect.fromLTRB(0, 0, 300, 300), Paint());
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(const Offset(1, 100), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
