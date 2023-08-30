import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/scaffolds/inside_scaffold.dart';
import 'package:forfun_teller/widgets/shop_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      title: 'Mağaza',
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  'Hoş geldin gizemli yolcu! ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                PadderBox(),
                Text(
                  'Parıltılı dünyamızın kapıları sizi bekliyor. Burada, '
                  'en nadide taşlar ve büyülü mücevherler arasında kaybolup, ruhunuza ışıltı katmanın zamanı geldi.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShopCard(
                diamondCount: 10,
                price: 15.99,
              ),
              ShopCard(
                diamondCount: 20,
                price: 23.99,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShopCard(
                diamondCount: 30,
                price: 29.99,
              ),
              ShopCard(
                diamondCount: 50,
                price: 39.99,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
