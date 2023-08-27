import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/screens/carousel_screen.dart';
import 'package:page_transition/page_transition.dart';

class CoffeePage extends StatefulWidget {
  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      title: 'Kahve Falı',
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: const DescTexts(),
          ),
          OutlinedButton(
            style: kOutlinedButtonStyle,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: const Duration(milliseconds: 500),
                      type: PageTransitionType.scale,
                      alignment: Alignment.center,
                      child: const CarouselScreen()));
            },
            child: const Text(
              'Yolculuğa Başla',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class DescTexts extends StatelessWidget {
  const DescTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Merhaba, Gizemli Gezgin!",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "ForFun Teller'ın mistik dünyasına hoş geldin. 3 farklı fotoğrafı yüklememiz gerekiyor: birinci açı, ikinci açı ve fincan tabağı.",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Fotoğrafların bize ulaştığında, falcılarımızın perde arkasındaki büyülü dansı başlayacak. Geleceğe dair ipuçları ve sırlar ortaya çıkacak.",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Hazır mısın? Unutma, bu sadece eğlenceli bir fal deneyimi. Falcılarımızın yorumları seni büyülemeyecek, ama bazı sırlar açığa çıkabilir.",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Forfun Teller ile bu gizemli yolculuğa çık, fotoğraflarını yükle ve kahve telvesinin sırlarını öğren.",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
