import 'package:flutter/material.dart';

class GenderGestures extends StatelessWidget {
  final String gender;
  final IconData icon;
  final void Function() onTapped;
  final String currentGender;

  const GenderGestures({
    super.key,
    required this.gender,
    required this.icon,
    required this.onTapped,
    required this.currentGender,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentGender != gender
              ? Colors.black.withOpacity(0.8)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.1,
              color: currentGender == gender
                  ? Colors.black.withOpacity(0.8)
                  : Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                  color: currentGender == gender ? Colors.black : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
