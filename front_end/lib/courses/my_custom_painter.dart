import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class MyCustomPainter extends StatelessWidget {
  const MyCustomPainter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is title"),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          painter: CanvasDraw(faces: []),
          child: const Text("Hello"),
        ),
      ),
    );
  }
}

class CanvasDraw extends CustomPainter {
  final List<Face> faces;

  CanvasDraw({super.repaint, required this.faces});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;
    final path = Path();
    path.moveTo(0, size.height / 2);
    Offset end = Offset(size.width, size.height / 2);
    Offset start = Offset(0, size.height / 2);

    canvas.drawLine(start, end, paint);
    final paint2 = Paint()..strokeWidth = 2.0;
    for (var e in faces) {
      Rect rect = Rect.fromLTRB(
          e.boundingBox.left * (size.width / e.boundingBox.left),
          e.boundingBox.left * (size.height / e.boundingBox.top),
          e.boundingBox.left * (size.height / e.boundingBox.right),
          e.boundingBox.left * (size.height / e.boundingBox.bottom));
      canvas.drawRect(rect, paint2);
      canvas.drawRect(e.boundingBox, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
