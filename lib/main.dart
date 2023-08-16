import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//#592538
  // #D9736A
  //#A64153
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: kMainColorScheme,
        scaffoldBackgroundColor: const Color(0xFF592538),
        fontFamily: 'Kanit',
      ),
      title: 'Forfun Teller',
      routes: {
        '/': (context) => const WelcomePage(),
      },
    );
  }
}
