import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImagedScaffold extends StatelessWidget {
  final Widget childWidget;
  final String? bgImage;

  ImagedScaffold({required this.childWidget, required this.bgImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgImage != null
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bgImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(1),
                  const Color(0xFF592538).withOpacity(0.5),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: SafeArea(
              child: childWidget,
            ),
          ),
          Provider.of<AuthServices>(context).isLoading ||
                  Provider.of<FortuneServices>(context).isLoading
              ? Center(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const SpinKitSpinningLines(
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
