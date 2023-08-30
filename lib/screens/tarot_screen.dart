import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_flipper.dart';
import 'package:forfun_teller/widgets/scaffolds/inside_scaffold.dart';

class TarotPage extends StatelessWidget {
  const TarotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final con = FlipCardController();
    return InsideScaffold(
      title: 'Günün Tarot Kartı',
      childWidget: Container(
        alignment: Alignment.center,
        child: TarotFlipper(
          con: con,
        ),
      ),
    );
  }
}
