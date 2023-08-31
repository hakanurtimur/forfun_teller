import 'package:flutter/material.dart';

class TarotText extends StatelessWidget {
  const TarotText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Text(
        'Kartları çevirmek için üzerlerine tıklayın. Sonrasında falınızı görebilirsiniz.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
