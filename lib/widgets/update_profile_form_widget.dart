import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';

class UpdateProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onNameSaved;
  final void Function() onSubmit;
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir isim girin.';
    }
    if (value.length > 12) {
      return 'İsim 12 karakterden uzun olamaz.';
    }
    return null;
  }

  UpdateProfileForm({
    required this.formKey,
    required this.onEmailSaved,
    required this.onNameSaved,
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
            'Profili Düzenle',
            textAlign: TextAlign.center,
            style: kSectionTitleStyle,
          ),
          const PadderBox(),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    print('hakö');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: TextButton(
                        onPressed: () {
                          print('hakö');
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      backgroundImage: NetworkImage(
                        Provider.of<AuthServices>(context)
                                .currentUser!
                                .photoURL ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: TextEditingController(
                      text: Provider.of<AuthServices>(context)
                              .currentUser!
                              .displayName ??
                          ''),
                  validator: (value) {
                    print(_validateName(value));
                    return _validateName(value);
                  },
                  onSaved: onNameSaved,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: kInputDecorationStyle.copyWith(
                      hintText: 'İsminiz',
                      prefixIcon: const Icon(Icons.person)),
                ),
                const PadderBox(),
                TextFormField(
                  controller: TextEditingController(
                      text: Provider.of<AuthServices>(context)
                              .currentUser!
                              .email ??
                          ''),
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
                const PadderBox(),
                const PadderBox(),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onSubmit,
                    child: const Text(
                      'Profili Güncelle',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
