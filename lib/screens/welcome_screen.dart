import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: kMainBgGradient,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(
                image: AssetImage('images/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground),
                      padding: const EdgeInsets.all(5),
                    ),
                    onPressed: () {},
                    child: ListTile(
                      leading: const Image(
                        width: 30,
                        height: 30,
                        image: AssetImage('images/icon.png'),
                      ),
                      title: GradientAnimationText(
                        duration: const Duration(seconds: 3),
                        colors: const [
                          Color(0xFFD9736A),
                          Colors.white,
                        ],
                        text: Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
