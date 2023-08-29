import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/scaffolds/imaged_scaffold.dart';
import 'package:forfun_teller/widgets/form-widgets/update_profile_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email;
  String? name;

  onEmailSaved(String? value) {
    email = value;
  }

  onNameSaved(String? value) {
    name = value;
  }

  void onSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    await Provider.of<AuthServices>(context, listen: false).updateProfile(
        email: email!,
        name: name!,
        context: context,
        currentUser: currentUser!);
    Navigator.pushReplacementNamed(context, '/logged');
  }

  @override
  Widget build(BuildContext context) {
    return ImagedScaffold(
      bgImage: null,
      childWidget: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UpdateProfileForm(
                    formKey: formKey,
                    onEmailSaved: onEmailSaved,
                    onNameSaved: onNameSaved,
                    onSubmit: onSubmit,
                  )
                ],
              ),
            ),
            BackButton(
              color: Colors.white,
              onPressed: () {
                Provider.of<AuthServices>(context, listen: false).resetImage();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
