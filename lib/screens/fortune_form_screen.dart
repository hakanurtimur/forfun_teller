import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:forfun_teller/widgets/auth_scaffold.dart';
import 'package:forfun_teller/widgets/fortune_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/widgets/positioned_back_button.dart';

class FortuneFormPage extends StatefulWidget {
  const FortuneFormPage({super.key});
  @override
  State<FortuneFormPage> createState() => _FortuneFormPageState();
}

class _FortuneFormPageState extends State<FortuneFormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _selectedRelationship = 0;
  String _selectedRelationshipText = 'Evli';
  String _gender = 'Erkek';
  String _name = '';
  DateTime _date = DateTime(1996, 12, 24);
  final List<String> relationshipList = <String>[
    'Evli',
    'Bekar',
    'İlişkisi var',
    'Nişanlı',
    'Ayrılmış',
    'Boşanmış',
    'Flörtü var',
  ];

  Future<void> onSubmit(BuildContext inContext) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    formKey.currentState!.validate();
    formKey.currentState!.save();
    if (_name.isEmpty) {
      return;
    }
    Provider.of<FortuneServices>(context, listen: false).setFortune(
        context: context,
        bornDate: _date,
        ownerName: _name,
        relationship: _selectedRelationshipText,
        uid: currentUser!.uid,
        gender: _gender);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      childWidget: Stack(
        children: [
          SingleChildScrollView(
            child: FortuneFormWidget(
                formKey: formKey,
                onNameSaved: (value) {
                  setState(() {
                    _name = value!;
                  });
                },
                context: context,
                onDateSaved: (value) {
                  setState(() {
                    _date = value;
                  });
                },
                selectedRelationship: _selectedRelationship,
                gender: _gender,
                genderSelection: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                onRelationshipSaved: (value) {
                  setState(() {
                    _selectedRelationship = value;
                    _selectedRelationshipText = relationshipList[value];
                  });
                },
                selectedDate: _date,
                onSubmit: () async {
                  await onSubmit(context);
                }),
          ),
          const PositionedBackButton(
              buttonTitle: 'Geri Dön', isButtonResetting: false)
        ],
      ),
      bgImage: 'images/fortune_actions_bg2.jpeg',
    );
  }
}
