import 'package:image_picker/image_picker.dart';

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  XFile imageFile;

  ImageUploadModel({
    required this.isUploaded,
    required this.uploading,
    required this.imageFile
  });
}
