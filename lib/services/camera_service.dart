import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> tomarFoto() async {
    final XFile? foto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    return foto;
  }
}
