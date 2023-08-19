import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/main_scaffold.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        childWidget: Container(
          child: Center(child: Text('Kayıt başarılı')),
        ),
        bgImage: 'images/welcome_bg1.jpg');
  }
}
