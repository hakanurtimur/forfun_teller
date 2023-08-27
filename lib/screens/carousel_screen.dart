import 'package:flutter/material.dart';
import 'package:forfun_teller/screens/fortune_form_screen.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:forfun_teller/widgets/auth_scaffold.dart';
import 'package:forfun_teller/widgets/carousel_item.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/widgets/carousel_gestures.dart';
import 'package:forfun_teller/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:forfun_teller/widgets/positioned_back_button.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});
  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _current = 0;
  bool isContentLoaded = false;
  bool fadedOut = false;
  bool isScreenLoaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isScreenLoaded = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isContentLoaded = true;
      });
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        fadedOut = true;
      });
    });
  }

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isScreenLoaded ? 1 : 0,
      duration: const Duration(milliseconds: 400),
      child: AuthScaffold(
        childWidget: AnimatedOpacity(
          opacity: fadedOut ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const Text(
                    'İlk olarak fincanınızın fotoğraflarını ekleyin.',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CarouselGestures(
                        itemTitle: 'Fincan 1. Açı',
                        onPressed: () {
                          carouselController.animateToPage(0);
                        },
                        currentIndex: _current,
                        index: 0,
                      ),
                      CarouselGestures(
                        itemTitle: 'Fincan 2. Açı',
                        onPressed: () {
                          carouselController.animateToPage(1);
                        },
                        currentIndex: _current,
                        index: 1,
                      ),
                      CarouselGestures(
                        itemTitle: 'Fincan Tabağı',
                        onPressed: () {
                          carouselController.animateToPage(2);
                        },
                        currentIndex: _current,
                        index: 2,
                      )
                    ],
                  ),
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                        initialPage: 0,
                        height: 400,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: [
                      CarouselItem(
                        selectedImage: Provider.of<FortuneServices>(context)
                            .selectedImage1,
                        itemTitle: 'Fincan 1. Açı',
                        imageNumber: 1,
                      ),
                      CarouselItem(
                        selectedImage: Provider.of<FortuneServices>(context)
                            .selectedImage2,
                        itemTitle: 'Fincan 2. Açı',
                        imageNumber: 2,
                      ),
                      CarouselItem(
                        selectedImage: Provider.of<FortuneServices>(context)
                            .selectedImage3,
                        itemTitle: 'Fincan Tabağı',
                        imageNumber: 3,
                      ),
                    ],
                  ),
                  OutlinedButton(
                    style: kOutlinedButtonStyle,
                    onPressed: () {
                      if (!Provider.of<FortuneServices>(context, listen: false)
                          .imageCheck()) {
                        customToast(
                            msg: 'Lütfen 3 fotoğrafı da ekleyin.',
                            context: context,
                            backgroundColor: kErrorColor);
                      } else {
                        Navigator.pushNamed(context, '/fortune_form');
                      }
                    },
                    child: const Text(
                      'Devam Et',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const PositionedBackButton(
                buttonTitle: 'Vazgeç',
                // düzelt
                isButtonResetting: true,
              )
            ],
          ),
        ),
        bgImage: 'images/fortune_actions_bg2.jpeg',
      ),
    );
  }
}

//firebaseden unique id alınacak
// dolayısıyla data typlarını artık yavaş yavaş yazamalıyız
// giden kahve falının altına form gelmeli sonuçta kim için istendiği bilgisi de olmalı
// formu da yazılacak
// formu yazarken de provider ile yapmalıyız
// firebase storage

// --> burada
// Provider.of<ImageSelection>(context, listen: false)
//     .selectedImage1 !=
// null &&
// Provider.of<ImageSelection>(context, listen: false)
//     .selectedImage2 !=
// null &&
// Provider.of<ImageSelection>(context, listen: false)
//     .selectedImage3 !=
// null
// ? (Provider.of<StorageService>(context, listen: false)
//     .imageUploader(
// Provider.of<ImageSelection>(context,
// listen: false)
//     .selectedImage1!,
// 'image1',
// context))
//     : customToast(
// msg: 'Lütfen tüm fotoğrafları yükleyin.',
// context: context,
// backgroundColor: kErrorColor,
// );
