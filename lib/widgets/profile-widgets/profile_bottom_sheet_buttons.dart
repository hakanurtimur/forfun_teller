import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:provider/provider.dart';

class ProfileBSheetButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool gallery;
  const ProfileBSheetButton({
    super.key,
    required this.icon,
    required this.title,
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
              Provider.of<AuthServices>(context, listen: false)
                  .captureImageFromGallery(context);
            } else {
              Provider.of<AuthServices>(context, listen: false)
                  .captureImageFromCamera(context);
            }
            Navigator.pop(context);
          },
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
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
