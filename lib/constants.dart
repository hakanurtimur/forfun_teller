import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

const ColorScheme kMainColorScheme = ColorScheme.dark(
  primary: Color(0xFF592538),
  secondary: Color(0xFFD9736A),
  background: Color(0xFFA64153),
  surface: Color(0xFFD9736A),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onBackground: Colors.white,
  onSurface: Colors.white,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
);

const List<String> welcomeTranslations = [
  'Hoşgeldin', // Türkçe
  'Bienvenido', // İspanyolca
  'Welcome', // İngilizce
  'Benvenuto', // İtalyanca
  'Willkommen', // Almanca
  'Bienvenue', // Fransızca
  '歡迎', // Çince (Geleneksel)
  'مرحبًا', // Arapça
];

const TextStyle kSectionTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

const InputDecoration kInputDecorationStyle = InputDecoration(
  prefixIcon: Icon(Icons.email),
  hintText: 'E-mail',
  hintStyle: TextStyle(fontSize: 15),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
); // copy with text

final Color kSuccessColor = Colors.black.withOpacity(0.5);
final Color kErrorColor = const Color(0xFF592538).withOpacity(0.5);
const Color kInfoColor = Color(0xFFD9736A);

void customToast({
  required String msg,
  required BuildContext context,
  required Color backgroundColor,
}) {
  showToast(
    msg,
    textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
    backgroundColor: backgroundColor,
    context: context,
    animation: StyledToastAnimation.slideFromBottomFade,
    reverseAnimation: StyledToastAnimation.slideToBottomFade,
    position: StyledToastPosition.bottom,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 3),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
    fullWidth: true,
    isHideKeyboard: true,
  );
}
