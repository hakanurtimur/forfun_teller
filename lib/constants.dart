import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

const ColorScheme kMainColorScheme = ColorScheme.dark(
  primary: Color(0xFF592538),
  secondary: Color(0xFFDC9F20),
  background: Color(0xFFA64153),
  surface: Color(0xFFDC9F20),
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

final Color kSuccessColor = Colors.green.withOpacity(1);
final Color kErrorColor = Colors.red.withOpacity(1);
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

final ButtonStyle kOutlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.transparent,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: const BorderSide(color: Colors.white, width: 2),
  ),
);

BoxDecoration kBigModalBoxDecoration(BuildContext context) {
  return BoxDecoration(
    border: null,
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.background,
      ],
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
}

class PadderBox extends StatelessWidget {
  const PadderBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }
}
