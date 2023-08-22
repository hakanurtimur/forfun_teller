import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Column(
            children: [
              Image.asset('images/defaultu.png'),
              const Text(
                'Fal Bak',
                style: kButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
