import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';

Widget buildBottomSheet(
    BuildContext context, String cardName, String cardDesc, String cardImg) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        Container(
          decoration: kBigModalBoxDecoration(context),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Günün Kartı',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    cardName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                width: 200,
                height: 300,
                child: Hero(
                  tag: 'card',
                  child: Image.asset(
                    cardImg,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, bottom: 30, top: 10),
                child: Text(
                  cardDesc,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0, // İstediğiniz konumu ayarlayın
          left: 0, // İstediğiniz konumu ayarlayın
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
