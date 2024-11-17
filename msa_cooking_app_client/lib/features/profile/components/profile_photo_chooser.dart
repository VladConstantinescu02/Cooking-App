import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickAnImage () async {
  final picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.gallery);
}

Future<CroppedFile?> croppedImage(String path) async {
  final cropper = ImageCropper();
  return await cropper.cropImage(sourcePath: path);
}