import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/scaffolds/imaged_scaffold.dart';
import 'package:forfun_teller/widgets/form-widgets/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dsipose çalıştı');
  }

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
    return ImagedScaffold(
      bgImage: 'images/welcome_bg2.jpg',
      childWidget: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              width: 100,
              height: 100,
              image: AssetImage('images/icon.png'),
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
