import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final picker = ImagePicker();

  static Future<String?> pickImageBase64() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return null;

    final bytes = await File(picked.path).readAsBytes();
    return base64Encode(bytes);
  }
}
