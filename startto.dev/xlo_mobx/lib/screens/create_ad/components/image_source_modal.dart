import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({
    super.key,
    required this.onImageSelected,
  });

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: getFromCamera,
                  child: const Text("Câmera"),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: getFromGallery,
                  child: const Text("Galeria"),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CupertinoActionSheet(
      title: const Text("Selecionar foto para o anúncio"),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          "Cancelar",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: getFromCamera,
          child: const Text("Câmera"),
        ),
        CupertinoActionSheetAction(
          onPressed: getFromGallery,
          child: const Text("Galeria"),
        ),
      ],
    );
  }

  Future<void> getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      imageSelected(imageFile);
    }
  }

  Future<void> getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      imageSelected(imageFile);
    }
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Editar imagem",
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white,
        ),
      ],
    );
    onImageSelected(File(croppedFile!.path));
  }
}
