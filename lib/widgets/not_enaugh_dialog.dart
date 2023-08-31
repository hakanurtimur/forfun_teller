import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/screens/logged_in_screen.dart';

class NotEnaughDialog extends StatelessWidget {
  const NotEnaughDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Yeterli Forfun Diamond'ınız yok.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              const PadderBox(),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoggedInScreen(
                        initialPageIndex: 4,
                      );
                    }),
                    (route) => false,
                  );
                },
                style: kOutlinedButtonStyle,
                child: const Text('Mağazaya git',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoggedInScreen(
                        initialPageIndex: 0,
                      );
                    }),
                    (route) => false,
                  );
                },
                style: kOutlinedButtonStyle,
                child: const Text('Ana Sayfaya Dön',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
            ],
          )),
    );
  }
}
