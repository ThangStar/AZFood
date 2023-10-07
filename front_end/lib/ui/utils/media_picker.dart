import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

enum TypeMediaPicker { gallery, camera, video, file }

Future<XFile?> mediaPicker(TypeMediaPicker typeMediaPicker) async {
  switch (typeMediaPicker) {
    case TypeMediaPicker.gallery:
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    case TypeMediaPicker.camera:
      return await ImagePicker().pickImage(source: ImageSource.camera);
    default:
      return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
