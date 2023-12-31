import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/diamond_services.dart';
import 'package:forfun_teller/services/provider/tarot_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InsideScaffold extends StatelessWidget {
  final Widget childWidget;
  final String? title;

  InsideScaffold({required this.childWidget, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Text(title!, style: kSectionTitleStyle),
            )
          : null,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: childWidget,
          ),
          Provider.of<TarotServices>(context).isLoading ||
                  Provider.of<DiamondService>(context).sellingDiamondLoading
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
