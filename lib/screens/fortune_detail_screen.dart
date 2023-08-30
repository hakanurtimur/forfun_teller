import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/scaffolds/imaged_scaffold.dart';

class FortuneDetailPage extends StatelessWidget {
  final String? fortuneText;
  final String? fortuneTitle;
  final String fortuneOwner;
  const FortuneDetailPage(
      {super.key,
      required this.fortuneText,
      required this.fortuneTitle,
      required this.fortuneOwner});

  @override
  Widget build(BuildContext context) {
    return ImagedScaffold(
      bgImage: 'images/fortune_detail_bg.jpg',
      childWidget: Stack(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(fortuneTitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const PadderBox(),
                  Expanded(
                    // Wrap with Expanded to allow the SingleChildScrollView to take available space
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Sevgili $fortuneOwner',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const PadderBox(),
                            Text(
                              fortuneText!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          const Positioned(
              top: 0, left: 0, child: BackButton(color: Colors.white)),
        ],
      ),
    );
  }
}
