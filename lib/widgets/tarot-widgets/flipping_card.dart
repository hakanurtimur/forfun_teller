import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:forfun_teller/services/provider/tarot_services.dart';
import 'package:provider/provider.dart';

class FlippingCard extends StatefulWidget {
  final Function onFlip;
  final String imageUrl;
  const FlippingCard({super.key, required this.imageUrl, required this.onFlip});

  @override
  State<FlippingCard> createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard> {
  FlipCardController con = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.5,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (Provider.of<TarotServices>(context, listen: false)
                .getAllFlipped()) {
              return;
            }
            if (con.state!.isFront) {
              con.flipcard();
              widget.onFlip();
            }
          });
        },
        child: FlipCard(
          onTapFlipping: false,
          rotateSide: RotateSide.left,
          controller: con,
          animationDuration: const Duration(milliseconds: 300),
          axis: FlipAxis.vertical,
          frontWidget: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
            ),
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.width * 0.42,
            child: Image.asset(
              Provider.of<TarotServices>(context).getAllFlipped()
                  ? widget.imageUrl
                  : 'images/tarotbg.png',
              fit: BoxFit.cover,
            ),
          ),
          backWidget: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
            ),
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.width * 0.42,
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
