import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/widgets/gender_gestures.dart';

class FortuneFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onNameSaved;
  final BuildContext context;
  final void Function(DateTime) onDateSaved;
  final int selectedRelationship;
  final void Function(int) onRelationshipSaved;
  final String gender;
  final void Function(String) genderSelection;
  final DateTime selectedDate;
  final Function onSubmit;

  final DateTime date = DateTime(2016, 10, 26);

  FortuneFormWidget(
      {super.key,
      required this.formKey,
      required this.onNameSaved,
      required this.context,
      required this.onDateSaved,
      required this.selectedRelationship,
      required this.gender,
      required this.genderSelection,
      required this.onRelationshipSaved,
      required this.selectedDate,
      required this.onSubmit});
  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Lütfen bir isim girin.';
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Geçerli bir isim girin.';
    }

    return null; // Doğrulama başarılı, hata yok.
  }

  final double _kItemExtent = 32.0;
  final List<String> relationshipList = <String>[
    'Evli',
    'Bekar',
    'İlişkisi var',
    'Nişanlı',
    'Ayrılmış',
    'Boşanmış',
    'Flörtü var',
  ];
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void _showDialog2(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Bilgilerinizi girin',
                    style: kSectionTitleStyle.copyWith(
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        cursorColor: Colors.white,
                        decoration: kInputDecorationStyle.copyWith(
                            hintText: 'İsminiz',
                            prefixIcon: const Icon(Icons.person_2)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return validateName(value!);
                        },
                        onSaved: onNameSaved,
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        onPressed: () => _showDialog(
                          CupertinoDatePicker(
                            dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: selectedDate,
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            minimumDate: DateTime(1900, 1, 1),
                            maximumDate: DateTime(2016, 12, 30),
                            onDateTimeChanged: (DateTime newDate) {
                              onDateSaved(newDate);
                            },
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(FontAwesomeIcons.birthdayCake,
                                    color: Colors.white),
                                SizedBox(width: 12),
                                Text(
                                  'Doğum Tarihiniz:',
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 0.5,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        // Display a CupertinoPicker with list of fruits.
                        onPressed: () => _showDialog2(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This sets the initial item.
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedRelationship,
                            ),
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              onRelationshipSaved(selectedItem);
                            },
                            children: List<Widget>.generate(
                                relationshipList.length, (int index) {
                              return Center(
                                  child: Text(relationshipList[index]));
                            }),
                          ),
                        ),
                        // This displays the selected fruit name.
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.favorite, color: Colors.white),
                                SizedBox(width: 12),
                                Text(
                                  'İlişki Durumunuz:',
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              relationshipList[selectedRelationship],
                              style: const TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GenderGestures(
                              currentGender: gender,
                              icon: FontAwesomeIcons.mars,
                              gender: 'Erkek',
                              onTapped: () {
                                genderSelection('Erkek');
                              }),
                          GenderGestures(
                              currentGender: gender,
                              icon: FontAwesomeIcons.venus,
                              gender: 'Kadın',
                              onTapped: () {
                                genderSelection('Kadın');
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            style: kOutlinedButtonStyle,
            onPressed: () {
              onSubmit();
            },
            child: const Text(
              'Gönder',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
