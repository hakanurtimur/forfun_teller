import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';

class ShopPage extends StatelessWidget {
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
                  'Parıltılı dünyamızın kapıları sizi bekliyor. Burada, en nadide taşlar ve büyülü mücevherler arasında kaybolup, ruhunuza ışıltı katmanın zamanı geldi.',
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

class ShopCard extends StatelessWidget {
  final int diamondCount;
  final double price;

  const ShopCard({
    required this.diamondCount,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0.2,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
            context: context,
            builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text('Satın alım başarılı'))),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    diamondCount.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.diamond,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text('${price.toStringAsFixed(2)} ₺',
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
