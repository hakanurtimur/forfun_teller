import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_flipper.dart';
import 'package:forfun_teller/widgets/scaffolds/inside_scaffold.dart';

class TarotPage extends StatelessWidget {
  const TarotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      title: 'Günlük Tarot Falı',
      childWidget: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: TarotFlipper(),
        ),
      ),
    );
  }
}
