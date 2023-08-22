import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfun_teller/screens/shop_screen.dart';
import 'package:forfun_teller/screens/main_screen.dart';
import 'package:forfun_teller/screens/tarot_screen.dart';
import 'profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:forfun_teller/screens/notification_screen.dart';

class LoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainNavigationBar();
  }
}

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    TarotPage(),
    ProfilePage(),
    NotificationPage(),
    ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Colors.black],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('images/logo.png', height: 100),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: ConvexAppBar(
          height: 60,
          activeColor: Theme.of(context).colorScheme.onBackground,
          backgroundColor: Colors.black.withOpacity(0.7),
          initialActiveIndex: 0,
          style: TabStyle.react,
          items: const [
            TabItem(
              icon: Icon(Icons.coffee),
              title: 'Kahve Falı',
            ),
            TabItem(
              icon: Icon(Icons.star),
              title: 'Tarot',
            ),
            TabItem(
              icon: Icon(Icons.person),
              title: 'Profil',
            ),
            TabItem(
              icon: Icon(Icons.notifications),
              title: 'Bildirimler',
            ),
            TabItem(
              icon: Icon(Icons.shopping_cart),
              title: 'Mağaza',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
