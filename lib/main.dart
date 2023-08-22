import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/screens/logged_in_screen.dart';
import 'package:forfun_teller/services/provider/cloud_services.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'services/provider/auth_services.dart';
import 'screens/profile_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => CloudServices(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: kMainColorScheme,
          scaffoldBackgroundColor: const Color(0xFF592538),
          fontFamily: 'Kanit',
        ),
        title: 'Forfun Teller',
        routes: {
          '/': (context) => const WelcomePage(),
          '/signup': (context) => SignupPage(),
          '/login': (context) => LoginPage(),
          '/logged': (context) => LoggedInScreen(),
          '/profile': (context) => ProfilePage(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
