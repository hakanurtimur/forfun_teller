import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/main_scaffold.dart';
import 'package:forfun_teller/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? passwordRepeat;

  void onEmailSaved(String? value) {
    email = value;
  }

  void onPasswordSaved(String? value) {
    password = value;
  }

  void onPasswordRepeatSaved(String? value) {
    passwordRepeat = value;
  }

  void onSubmit() async {
    formKey.currentState!.validate();
    formKey.currentState!.save();
    if (password != passwordRepeat) {
      customToast(
          context: context,
          msg: 'Şifreler eşleşmiyor',
          backgroundColor: kErrorColor);
      return;
    } else {
      await Provider.of<AuthServices>(context, listen: false).signUpWithEmail(
        email: email!,
        password: password!,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      bgImage: 'images/welcome_bg2.jpg',
      childWidget: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Hero(
              tag: 'icon',
              child: Image(
                width: 100,
                height: 100,
                image: AssetImage('images/icon.png'),
              ),
            ),
            const SizedBox(height: 50),
            SignupFormWidget(
              formKey: formKey,
              onEmailSaved: onEmailSaved,
              onPasswordSaved: onPasswordSaved,
              onPasswordRepeatSaved: onPasswordRepeatSaved,
              onSubmit: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
