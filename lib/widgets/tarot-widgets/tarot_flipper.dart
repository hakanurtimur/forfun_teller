import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/tarot_services.dart';
import 'package:forfun_teller/widgets/tarot-widgets/flipping_card.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_outlined_button.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_text.dart';
import 'package:provider/provider.dart';

class TarotFlipper extends StatefulWidget {
  const TarotFlipper({super.key});

  @override
  State<TarotFlipper> createState() => _TarotFlipperState();
}

class _TarotFlipperState extends State<TarotFlipper> {
  Widget buildButton(BuildContext context) {
    if (Provider.of<TarotServices>(context).getAllFlipped()) {
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

  // random imageler gelecek
  String image1Url = 'images/tarot_the_fool.png';
  String image2Url = 'images/tarot_the_highpriestess.png';
  String image3Url = 'images/tarot_the_magician.png';
  String image1Id = 'tarot_the_fool';
  String image2Id = 'tarot_the_highpriestess';
  String image3Id = 'tarot_the_magician';
  bool isFlipped1 = false;
  bool isFlipped2 = false;
  bool isFlipped3 = false;

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
                          Provider.of<TarotServices>(context, listen: false)
                              .setIsFlipped1(true);
                        },
                      )),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: FlippingCard(
                    imageUrl: 'images/tarot_the_highpriestess.png',
                    onFlip: () {
                      Provider.of<TarotServices>(context, listen: false)
                          .setIsFlipped2(true);
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
                          Provider.of<TarotServices>(context, listen: false)
                              .setIsFlipped3(true);
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
