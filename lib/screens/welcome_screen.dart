import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        skipTextButton: const Text(
          'Keşfet',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        pageBackgroundGradient: LinearGradient(
          colors: [
            Colors.black,
            Theme.of(context).colorScheme.primary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        centerBackground: true,
        onFinish: () {
          Navigator.pushNamed(context, '/signup');
        },
        trailingFunction: () {
          Navigator.pushNamed(context, '/login');
        },
        headerBackgroundColor: Colors.black,
        finishButtonText: 'Bize Katılın',
        finishButtonStyle: FinishButtonStyle(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        trailing: const Text(
          'Giriş yap',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        background: [
          Image.asset(
            'images/logo.png',
          ),
          Hero(
              tag: 'icon',
              child: Image.asset(
                'images/icon.png',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
              )),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: welcomeTranslations.map((text) {
                    return FadeAnimatedText(text,
                        textStyle: const TextStyle(
                          fontSize: 35,
                        ));
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                const Text(
                  'Merhaba ve hoş geldiniz! ForFun Teller, size eğlenceli ve merak uyandırıcı bir fal deneyimi sunuyor. Geleneksel kahve falının büyülü dünyası ile gizemli tarot kartlarının anlamlarını bir araya getiriyoruz. Kahve Falı ile sembollerin ve yorumların dilinden geleceği keşfedin. Tarot Kartları ile içsel dünyanıza bir bakış atın.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
