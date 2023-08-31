import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';

class ForgetFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onPasswordSaved;
  final void Function() onSubmit;

  const ForgetFormWidget({
    super.key,
    required this.formKey,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Emailinizi girin',
            textAlign: TextAlign.center,
            style: kSectionTitleStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Şifrenizi sıfırlamak için e-mailinizi girin, size bir e-mail '
            'göndereceğiz. E-mailinizi kontrol edin.',
            textAlign: TextAlign.center,
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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onSubmit,
                    child: const Text(
                      'Şifremi emailime gönder',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bir hesabın yok mu? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Text(
                      'Bir hesap edin.',
                      style: TextStyle(
                          color: const Color(0xFFA64153).withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Giriş ekranına dön',
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
