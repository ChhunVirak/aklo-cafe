import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/resources.dart';

class ImagePickerBox extends StatefulWidget {
  final ValueChanged<String?>? onSelectImage;
  const ImagePickerBox({
    super.key,
    this.onSelectImage,
  });

  @override
  State<ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  final ImagePicker _imagePicker = ImagePicker();

  File? _image;

  Future<void> _onSelectImage() async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    widget.onSelectImage?.call(imageFile?.path);
    debugPrint('Success ${imageFile?.path}');
    if (imageFile != null) {
      _image = File(imageFile.path);
      setState(() {});
    }
  }

  Future<void> _onOpenCamera() async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    widget.onSelectImage?.call(imageFile?.path);
    debugPrint('Success ${imageFile?.path}');
    if (imageFile != null) {
      _image = File(imageFile.path);
      setState(() {});
    }
  }

  void _showAndroidPopUp() {
    showModalBottomSheet(
      context: context,
      builder: (popContext) => SafeArea(
        minimum: const EdgeInsets.only(bottom: 30, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _onSelectImage().then((v) {
                          Navigator.pop(popContext);
                        });
                      },
                      icon: const Icon(Icons.image),
                    ),
                    const Text(
                      'Gallery',
                      style: AppStyle.medium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _onOpenCamera().then((v) {
                          Navigator.pop(popContext);
                        });
                      },
                      icon: const Icon(Icons.camera),
                    ),
                    const Text(
                      'Camera',
                      style: AppStyle.medium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAndroidPopUp();
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: _image != null
            ? SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              )
            : const Text(
                'Image',
                style: TextStyle(fontVariations: [FontVariation('wght', 900)]),
              ),
      ),
    );
  }
}
