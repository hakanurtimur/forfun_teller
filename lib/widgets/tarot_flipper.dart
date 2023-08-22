import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/cloud_services.dart';
import 'package:forfun_teller/widgets/build_bottom_sheet.dart';
import 'package:provider/provider.dart';

class TarotFlipper extends StatefulWidget {
  final FlipCardController con;
  const TarotFlipper({required this.con});

  @override
  State<TarotFlipper> createState() => _TarotFlipperState();
}

class _TarotFlipperState extends State<TarotFlipper> {
  String imageUrl = '';
  String cardName = '';
  String cardDescription = '';
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        isFlipped == false
            ? const Text(
                'Günün Kartını Çevir',
                style: TextStyle(fontSize: 22, color: Colors.white),
              )
            : Text(
                'Kartınız: $cardName',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
        FlipCard(
          rotateSide: RotateSide.right,
          onTapFlipping: false,
          controller: widget.con,
          animationDuration: const Duration(milliseconds: 300),
          axis: FlipAxis.vertical,
          frontWidget: Center(
            child: SizedBox(
              width: 200,
              height: 300,
              child: Image.asset(
                'images/tarotbg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          backWidget: SizedBox(
            width: 200,
            height: 300,
            child: Hero(
              tag: 'card',
              child: Image.asset(
                'images/tarotetc2.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        buildOutlinedButton(context),
      ],
    );
  }

  OutlinedButton buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        if (widget.con.state?.isFront == true) {
          widget.con.flipcard();
        }
        var data = await Provider.of<CloudServices>(context, listen: false)
            .getTarotById('bZzeUboLNUj07DyGPHSG');
        setState(() {
          imageUrl = data['imageUrl'];
          cardName = data['title'];
          cardDescription = data['desc'];
          isFlipped = true;
        });
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return buildBottomSheet(
                context, cardName, cardDescription, imageUrl);
          },
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
        );
      },
      child: isFlipped == false
          ? const Text(
              'Çevir',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          : const Text(
              'Detayları Gör',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
    );
  }
}
