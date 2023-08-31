import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/scaffolds/imaged_scaffold.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ImagedScaffold(
        childWidget: Container(
          child: Column(
            children: [
              const Text("Şifremi Unuttum"),
            ],
          ),
        ),
        bgImage: null);
  }
}
