import 'package:flutter/material.dart';

class TarotMeaningsColumn extends StatelessWidget {
  const TarotMeaningsColumn(
      {super.key,
      required this.tarotTitle,
      required this.tarotDesc,
      required this.imageUrl});

  final String tarotTitle;
  final String tarotDesc;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        tarotTitle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.44,
        height: MediaQuery.of(context).size.width * 0.84,
        child: Image.asset(imageUrl),
      ),
      Text(
        tarotDesc,
        style: TextStyle(fontSize: 14, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
