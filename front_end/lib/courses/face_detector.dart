import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:restaurant_manager_app/main.dart';
import 'package:restaurant_manager_app/utils/camera_to_input_image.dart';

class FaceDetectorScreen extends StatefulWidget {
  const FaceDetectorScreen({super.key});

  @override
  State<FaceDetectorScreen> createState() => _FaceDetectorScreenState();
}

class _FaceDetectorScreenState extends State<FaceDetectorScreen> {
  late CameraController cameraController;
  List<Face> faces = [
    Face(
        boundingBox: Rect.fromLTRB(100, 0, 0, 100),
        landmarks: {},
        contours: {}),
    Face(
        boundingBox: Rect.fromLTRB(300, 200, 200, 300), landmarks: {}, contours: {})
  ];
  late FaceDetector faceDetector;
  @override
  void initState() {
    //init face detect
    FaceDetectorOptions options = FaceDetectorOptions(
      enableLandmarks: true,
    );
    faceDetector = FaceDetector(options: options);

    cameraController = CameraController(
      cameras[1],
      ResolutionPreset.high,
    );
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    faceDetector.close();
    super.dispose();
  }

  _onCamera() {}

  _pause() {
    cameraController.pausePreview();
  }

  _startDetect() {
    cameraController.startImageStream((CameraImage image) async {
      InputImage ipImg = await cameraImageToInputImage(image);
      faceDetector.processImage(ipImg).then((value) {
          setState(() {
            faces = value;
          });
          print(
              "phát hiện thấy ${faces.length} khuôn mặt, vị trí: ${faces.length}");
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    if (!cameraController.value.isInitialized) {
      return Scaffold(
        body: Center(
            child:
                ElevatedButton(onPressed: _onCamera, child: Text("On camera"))),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: _startDetect, child: Text("Start detect")),
                    ElevatedButton(onPressed: _pause, child: Text("Pause")),
                  ],
                )),
            Positioned(
              top: 0,
              left: 0,
              child: Transform.scale(
                scale: 1,
                child: CustomPaint(
                  painter: OpenPainter(faces: faces, sizeScreen: sizeScreen),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({required this.faces, required this.sizeScreen});
  final List<Face> faces;
  final Size sizeScreen;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 0)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    if (faces.isNotEmpty) {
      for (var element in faces) {
        canvas.drawRect(element.boundingBox, paint1);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
