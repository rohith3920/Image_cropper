import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;

  Future<void> pickCropImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> cropImage() async {
    if (imageFile != null) {
      CroppedFile? croppedFile = await ImageCropper()
          .cropImage(sourcePath: imageFile!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ], uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.deepOrangeAccent,
          toolbarTitle: "Cropper",
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        )
      ]);
      if (croppedFile != null) {
        setState(() {
          imageFile = croppedFile as File?;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5ded6),
      appBar: AppBar(
        backgroundColor: Color(0xffc69f50),
        centerTitle: true,
        title: Text(
          'Pick & Crop Image',
        ),
      ),
      body: Column(
        children: [
          Center(
              child: imageFile == null ? Container() : Image.file(imageFile!)),
          TextButton(
            onPressed: pickCropImage,
            child: Text(
              'Pick&Crop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
