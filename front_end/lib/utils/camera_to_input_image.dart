import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

Future<InputImage> cameraImageToInputImage(CameraImage image) async {
  final WriteBuffer allBytes = WriteBuffer();
  for (final Plane plane in image.planes) {
    allBytes.putUint8List(plane.bytes);
  }
  final bytes = allBytes.done().buffer.asUint8List();
  final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
  InputImageRotation imageRotation = InputImageRotation.rotation0deg;
  final inputImageData = InputImageMetadata(
    size: imageSize,
    rotation: imageRotation,
    format: InputImageFormat.yuv420,
    bytesPerRow: image.planes[0].bytesPerRow,
  );
  InputImage inputImage = InputImage.fromBytes(
    bytes: bytes,
    metadata: inputImageData, //[dữ liệu hình ảnh đầu vào,]
  );
  return inputImage;
}
