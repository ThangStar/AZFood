import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_manager_app/main.dart';

class FaceDetectorScreen extends StatefulWidget {
  const FaceDetectorScreen({super.key});

  @override
  State<FaceDetectorScreen> createState() => _FaceDetectorScreenState();
}

class _FaceDetectorScreenState extends State<FaceDetectorScreen> {
  late CameraController cameraController;
  @override
  void initState() {
    cameraController = CameraController(
      cameras[1],
      ResolutionPreset.high,
    );
    cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);
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
    super.dispose();
  }

  _onCamera() {
    cameraController.value.lockedCaptureOrientation;
  }

  _pause() {
    cameraController.pausePreview();
  }

  @override
  Widget build(BuildContext context) {
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
                child: ElevatedButton(onPressed: _pause, child: Text("Pause"))),
          ],
        ),
      );
    }
  }
}
