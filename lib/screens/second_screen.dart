import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/custom_button.dart';
import 'package:forfun_teller/widgets/main_scaffold.dart';
import 'package:forfun_teller/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Hero(
            tag: 'icon',
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage('images/icon.png'),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 60,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: welcomeTranslations.map((text) {
                    return FadeAnimatedText(text,
                        textStyle: const TextStyle(
                          fontSize: 35,
                        ));
                  }).toList(),
                ),
              ),
              CustomButton(
                buttonTitle: const Text(
                  'Signup',
                  textAlign: TextAlign.center,
                  style: kButtonTextStyle,
                ),
                onPressFunc: () {},
                isNeedIcon: false,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                buttonTitle: const Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: kButtonTextStyle,
                ),
                onPressFunc: () {},
                isNeedIcon: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
