import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';

class PositionedBackButton extends StatelessWidget {
  final String buttonTitle;
  final bool isButtonResetting;
  const PositionedBackButton({
    super.key,
    required this.buttonTitle,
    required this.isButtonResetting,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.7),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          onPressed: () {
            isButtonResetting
                ? Provider.of<FortuneServices>(context, listen: false)
                    .resetImages()
                : null;
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 15,
          ),
          label: Text(
            buttonTitle,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
