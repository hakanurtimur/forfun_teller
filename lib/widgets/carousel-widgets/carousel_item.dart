import 'package:flutter/material.dart';
import 'dart:io';
import 'package:forfun_teller/widgets/gallery_buttom_sheet.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.selectedImage,
    required this.itemTitle,
    required this.imageNumber,
  });

  final File? selectedImage;
  final String itemTitle;
  final int imageNumber;

  Widget imageModal(BuildContext context, File selectedImage) {
    return Stack(children: [
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Image.file(selectedImage, fit: BoxFit.contain)),
          ],
        ),
      ),
      Positioned(
        top: 0, // İstediğiniz konumu ayarlayın
        left: 0, // İstediğiniz konumu ayarlayın
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          itemTitle,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.7),
          ),
          child: selectedImage != null
              ? Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                imageModal(context, selectedImage!),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent);
                      },
                      child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          height: 250,
                          width: 200,
                          child:
                              Image.file(selectedImage!, fit: BoxFit.contain)),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return galleryBottomSheet(context, imageNumber);
                          },
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Fotoğrafı değiştir',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return galleryBottomSheet(context, imageNumber);
                          },
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 70,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'Bir fotoğraf seçmek için dokun',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
