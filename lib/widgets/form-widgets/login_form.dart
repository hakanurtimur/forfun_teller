import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onPasswordSaved;
  final void Function() onSubmit;

  LoginFormWidget({
    required this.formKey,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Giriş Yapın',
            textAlign: TextAlign.center,
            style: kSectionTitleStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen e-mailinizi yazın';
                    }
                    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Geçersiz e-mail';
                    }
                    return null;
                  },
                  onSaved: onEmailSaved,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration:
                      kInputDecorationStyle.copyWith(hintText: 'E-mail'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir şifre girin';
                    }
                    return null;
                  },
                  onSaved: onPasswordSaved,
                  decoration: kInputDecorationStyle.copyWith(
                      hintText: 'Şifre', prefixIcon: const Icon(Icons.lock)),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onSubmit,
                    child: const Text(
                      'Giriş yap',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('— Ya da —'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 40,
                  ),
                  Container(
                    width: 20,
                    child: const VerticalDivider(
                      width: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bir hesabın yok mu? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Bir hesap edin.',
                      style: TextStyle(
                          color: const Color(0xFFA64153).withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
