import 'package:flutter/material.dart';

class IconedButton extends StatelessWidget {
  final IconData icon;

  final String title;
  const IconedButton({
    super.key,
    required this.icon,
    required this.title,
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
            minimumSize: const Size(80, 80),
            alignment: Alignment.center,
            shape: CircleBorder(),
          ),
          onPressed: () async {},
          child: Icon(icon, size: 40, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
