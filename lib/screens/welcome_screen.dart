import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/custom_button.dart';
import 'package:forfun_teller/widgets/main_scaffold.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Image(
            image: AssetImage('images/logo.png'),
          ),
          Column(
            children: [
              CustomButton(
                buttonTitle: const GradientAnimationText(
                  duration: Duration(seconds: 3),
                  colors: [
                    Color(0xFFD9736A),
                    Colors.white,
                  ],
                  text: Text(
                    'Get Started',
                    style: kButtonTextStyle,
                  ),
                ),
                onPressFunc: () {
                  Navigator.pushNamed(context, '/second');
                },
                isNeedIcon: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
