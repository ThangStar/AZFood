import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorPainter extends CustomPainter {
  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  @override
  void paint(final Canvas canvas, final Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color.fromARGB(255, 255, 0, 0);
    for (final Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
          translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
          translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
          translateY(
              face.boundingBox.bottom, rotation, size, absoluteImageSize),
        ),
        paint,
      );
      //draw the blue circle for detectd points of the face
      void paintCountour(final FaceContourType type) {
        final faceContour = face.contours[type];
        if(faceContour?.points!=null){
          for(final point in faceContour!.points){
            canvas.drawCircle(
              Offset(
                translateX(point.x.toDouble(), rotation, size, absoluteImageSize),
                translateY(point.y.toDouble(), rotation, size, absoluteImageSize),
              ),
              1.0,
              paint,
            );
          }
        }
      }
      paintCountour(FaceContourType.face);
      paintCountour(FaceContourType.leftEyebrowTop);
      paintCountour(FaceContourType.leftEyebrowBottom);
      paintCountour(FaceContourType.rightEyebrowTop);
      paintCountour(FaceContourType.rightEyebrowBottom);
      paintCountour(FaceContourType.leftEye);
      paintCountour(FaceContourType.rightEye);
      paintCountour(FaceContourType.upperLipTop);
      paintCountour(FaceContourType.upperLipBottom);
      paintCountour(FaceContourType.lowerLipTop);
      paintCountour(FaceContourType.lowerLipBottom);
      paintCountour(FaceContourType.noseBridge);
      paintCountour(FaceContourType.noseBridge);
      paintCountour(FaceContourType.leftCheek);
      paintCountour(FaceContourType.rightCheek);
    }
  }

  @override
  bool shouldRepaint(final FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize!= absoluteImageSize||oldDelegate.faces!=faces;
  }
}


double translateX (double X, InputImageRotation rotation, final Size size, final Size absoluteImageSize){
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return X*size.width/(Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
    case InputImageRotation.rotation270deg:
      return size.width-X* size.width/(Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
    default:
     return X*size.width/absoluteImageSize.width;
  }
}

double translateY(double Y, InputImageRotation rotation, final Size size, final Size absoluteImageSize){
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return Y*size.height/(Platform.isIOS ? absoluteImageSize.height : absoluteImageSize.width);
    default:
      return Y*size.height/absoluteImageSize.height;
  }
}