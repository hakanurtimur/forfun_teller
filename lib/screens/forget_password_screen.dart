import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/form-widgets/forget_form_widget.dart';
import 'package:forfun_teller/widgets/scaffolds/imaged_scaffold.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? email;

    void onEmailSaved(String? value) {
      email = value;
    }

    void onSubmit() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await Provider.of<AuthServices>(context, listen: false).forgetPassword(
          email: email!,
          context: context,
        );
        if (!context.mounted) return;
      }
    }

    return ImagedScaffold(
        childWidget: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Hero(
                  tag: 'icon',
                  child: Image(
                    width: 150,
                    height: 150,
                    image: AssetImage('images/icon.png'),
                  ),
                ),
                ForgetFormWidget(
                  formKey: formKey,
                  onEmailSaved: onEmailSaved,
                  onPasswordSaved: (value) {},
                  onSubmit: onSubmit,
                ),
              ]),
        ),
        bgImage: 'images/welcome_bg3.jpg');
  }
}
