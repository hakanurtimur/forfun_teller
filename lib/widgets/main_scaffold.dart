import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget childWidget;

  const MainScaffold({required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/welcome_bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(1),
                  const Color(0xFF592538).withOpacity(0.5),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: SafeArea(
              child: childWidget,
            ),
          ),
        ],
      ),
    );
  }
}
