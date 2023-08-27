import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:provider/provider.dart';

class CarouselGestures extends StatelessWidget {
  const CarouselGestures({
    super.key,
    required this.itemTitle,
    required this.onPressed,
    required this.currentIndex,
    required this.index,
  });
  final String itemTitle;
  final Function onPressed;
  final int currentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: index != currentIndex ? Colors.black : Colors.white,
                width: 2),
            color: (Provider.of<FortuneServices>(context)
                        .getSelectedImageByNumber(index) !=
                    null)
                ? Colors.white
                : Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Text(
            itemTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: (Provider.of<FortuneServices>(context)
                          .getSelectedImageByNumber(index) ==
                      null)
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
