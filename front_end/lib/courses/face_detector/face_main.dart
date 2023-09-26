import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:restaurant_manager_app/courses/face_detector/camera_view.dart';

import '../my_custom_painter.dart';

class FaceMain extends StatefulWidget {
  const FaceMain({super.key});

  @override
  State<FaceMain> createState() => _FaceMainState();
}

class _FaceMainState extends State<FaceMain> {
  @override final FaceDetector faceDetector =
  FaceDetector(options: FaceDetectorOptions(enableLandmarks: true));

  List<Face> faces = [];
  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: CustomPaint(
        painter: CanvasDraw(faces: faces),
      ),
      onImage: (InputImage inputImage) {
        faceDetector.processImage(inputImage).then((value) {
          setState(() {
            faces = value;
          });
          print(value.length);
          if (value.isNotEmpty) {
            print(value[0].boundingBox);
          }
        });
      },
    );
  }
}
