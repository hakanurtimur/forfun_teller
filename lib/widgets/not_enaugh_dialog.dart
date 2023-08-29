import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';

class NotEnaughDialog extends StatelessWidget {
  NotEnaughDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Yeterli Forfun Diamond'ınız yok.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              PadderBox(),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/logged');
                },
                child: Text('Mağazaya git',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                style: kOutlinedButtonStyle,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/logged');
                },
                child: Text('Ana Sayfaya Dön',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                style: kOutlinedButtonStyle,
              ),
            ],
          )),
    );
  }
}
