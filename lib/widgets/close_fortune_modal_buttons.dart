import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:provider/provider.dart';

class FortuneCloseButtons extends StatelessWidget {
  final BuildContext context;
  final bool reset;
  final String buttonTitle;
  const FortuneCloseButtons({
    super.key,
    required this.context,
    required this.reset,
    required this.buttonTitle,
  });

  @override
  Widget build(context) {
    return Positioned(
      width: MediaQuery.of(context).size.width * 0.3,
      top: 0,
      left: 0,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.7),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          reset
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
    );
  }
}
