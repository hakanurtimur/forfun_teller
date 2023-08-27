import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/auth_scaffold.dart';
import 'package:forfun_teller/widgets/update_profile_form_widget.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dsipose çalıştı');
  }

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
    formKey.currentState!.validate();
    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
