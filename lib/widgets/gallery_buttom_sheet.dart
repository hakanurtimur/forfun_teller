import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfun_teller/widgets/iconed_button.dart';

Widget galleryBottomSheet(BuildContext context, int imageNumber) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconedButton(
                      icon: FontAwesomeIcons.images,
                      title: 'Galeriden Seç',
                      imageNumber: imageNumber,
                      gallery: true,
                    ),
                  ),
                  Expanded(
                    child: IconedButton(
                      icon: FontAwesomeIcons.camera,
                      title: 'Fotoğraf Çek',
                      imageNumber: imageNumber,
                      gallery: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0, // İstediğiniz konumu ayarlayın
          left: 0, // İstediğiniz konumu ayarlayın
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
