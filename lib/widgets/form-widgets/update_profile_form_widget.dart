import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/profile-widgets/profile_image_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:provider/provider.dart';

class UpdateProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onNameSaved;
  final void Function() onSubmit;

  UpdateProfileForm({
    super.key,
    required this.formKey,
    required this.onEmailSaved,
    required this.onNameSaved,
    required this.onSubmit,
  });
  final currentUser = FirebaseAuth.instance.currentUser;
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
                Container(
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
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Provider.of<AuthServices>(context)
                                      .selectedImage !=
                                  null
                              ? Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      Provider.of<AuthServices>(context)
                                          .selectedImage!))
                              : Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(currentUser!.photoURL ??
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                ),
                        ),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.black.withOpacity(0.8),
                                context: context,
                                builder: (context) =>
                                    profileImageBottomSheet(context));
                          },
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: TextEditingController(
                      text: currentUser!.displayName ?? ''),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir isim girin.';
                    }
                    if (value.length > 12) {
                      return 'İsim 12 karakterden uzun olamaz.';
                    }
                    return null;
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
                  controller:
                      TextEditingController(text: currentUser!.email ?? ''),
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
