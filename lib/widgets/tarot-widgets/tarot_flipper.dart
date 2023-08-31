import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/tarot-widgets/flipping_card.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_outlined_button.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_text.dart';

class TarotFlipper extends StatefulWidget {
  const TarotFlipper({super.key});

  @override
  State<TarotFlipper> createState() => _TarotFlipperState();
}

class _TarotFlipperState extends State<TarotFlipper> {
  Widget buildButton(BuildContext context) {
    if (isFlipped1 && isFlipped2 && isFlipped3) {
      return TarotActionButton(
        imageUrl1: image1Url,
        imageUrl2: image2Url,
        imageUrl3: image3Url,
        image1Id: image1Id,
        image2Id: image2Id,
        image3Id: image3Id,
      );
    } else {
      return TarotText();
    }
  }

  late String image1Url;
  late String image2Url;
  late String image3Url;
  late String image1Id;
  late String image2Id;
  late String image3Id;
  bool isFlipped1 = false;
  bool isFlipped2 = false;
  bool isFlipped3 = false;
  String cardName = '';
  String cardDescription = '';

  @override
  void initState() {
    super.initState();

    // Random image fonksiyonu
    setState(() {
      image1Url = 'images/tarot_the_fool.png';
      image2Url = 'images/tarot_the_highpriestess.png';
      image3Url = 'images/tarot_the_magician.png';
      image1Id = 'tarot_the_fool';
      image2Id = 'tarot_the_highpriestess';
      image3Id = 'tarot_the_magician';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Tarot Falına Baktır',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          const PadderBox(),
          const PadderBox(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 1,
            child: Stack(
              children: [
                // bu image isimleri random gidecek 80 farklı kart var
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: Transform.rotate(
                      angle: -0.5,
                      child: FlippingCard(
                        imageUrl: 'images/tarot_the_fool.png',
                        onFlip: () {
                          setState(() {
                            isFlipped1 = true;
                          });
                        },
                      )),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: FlippingCard(
                    imageUrl: 'images/tarot_the_highpriestess.png',
                    onFlip: () {
                      setState(() {
                        isFlipped2 = true;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.55,
                  child: Transform.rotate(
                      angle: 0.5,
                      child: FlippingCard(
                        imageUrl: 'images/tarot_the_magician.png',
                        onFlip: () {
                          setState(() {
                            isFlipped3 = true;
                          });
                        },
                      )),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: buildButton(context)),
        ],
      ),
    );
  }
}
