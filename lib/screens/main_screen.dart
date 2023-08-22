import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';
import 'package:forfun_teller/widgets/iconed_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<XFile>? selectedImages;
  Future captureImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
    }
  }

  Future captureImageFromCamera() async {
    List<XFile> images = [];
    while (true) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) break;
      images.add(image);
    }

    setState(() {
      selectedImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      title: 'Kahve Falı Baktır',
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (selectedImages != null)
            Expanded(
              child: ListView.builder(
                itemCount: selectedImages!.length,
                itemBuilder: (context, index) {
                  return Image.file(File(selectedImages![index].path));
                },
              ),
            ),
          TextButton(
            onPressed: () async {
              setState(() {
                selectedImages = null;
              });
              await captureImageFromCamera();
            },
            child: Text('Yeniden seç'),
          ),
          TextButton(
              onPressed: () async {
                await captureImageFromCamera();
              },
              child: Text('Kameradan çek')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconedButton(
                icon: Icons.photo_library,
                title: 'Galeriden seç',
              ),
              IconedButton(
                icon: Icons.camera_alt,
                title: 'Kameradan çek',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
