import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:provider/provider.dart';

class IconedButton extends StatelessWidget {
  final IconData icon;
  final int imageNumber;
  final String title;
  final bool gallery;
  const IconedButton({
    super.key,
    required this.icon,
    required this.title,
    required this.imageNumber,
    required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            backgroundColor: Theme.of(context).colorScheme.primary,
            minimumSize: const Size(150, 100),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (gallery) {
              Provider.of<FortuneServices>(context, listen: false)
                  .captureImageFromGallery(imageNumber);
            } else {
              Provider.of<FortuneServices>(context, listen: false)
                  .captureImageFromCamera(imageNumber);
            }
            Navigator.pop(context);
          },
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
