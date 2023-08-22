import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/auth_scaffold.dart';
import 'package:forfun_teller/widgets/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void onSubmit() async {
    formKey.currentState!.validate();
    formKey.currentState!.save();
    await Provider.of<AuthServices>(context, listen: false).loginWithEmail(
      email: email!,
      password: password!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
            LoginFormWidget(
              formKey: formKey,
              onEmailSaved: onEmailSaved,
              onPasswordSaved: onPasswordSaved,
              onSubmit: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
