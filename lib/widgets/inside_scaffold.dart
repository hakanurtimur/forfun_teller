import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/services/provider/cloud_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InsideScaffold extends StatelessWidget {
  final Widget childWidget;
  final String title;

  InsideScaffold({required this.childWidget, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(title, style: kSectionTitleStyle),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: childWidget,
          ),
          Provider.of<CloudServices>(context).isLoading
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
