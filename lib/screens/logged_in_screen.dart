import 'package:flutter/material.dart';
import 'package:forfun_teller/screens/shop_screen.dart';
import 'package:forfun_teller/screens/coffee_screen.dart';
import 'package:forfun_teller/screens/tarot_screen.dart';
import 'package:forfun_teller/services/provider/diamond_services.dart';
import 'profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:forfun_teller/screens/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatelessWidget {
  final int initialPageIndex;
  const LoggedInScreen({super.key, this.initialPageIndex = 2});
  @override
  Widget build(BuildContext context) {
    return MainNavigationBar(
      initialPageIndex: initialPageIndex,
    );
  }
}

class MainNavigationBar extends StatefulWidget {
  final int initialPageIndex;
  const MainNavigationBar({super.key, this.initialPageIndex = 2});
  @override
  MainNavigationBarState createState() => MainNavigationBarState();
}

class MainNavigationBarState extends State<MainNavigationBar> {
  final currentUser = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  int? _diamondAmount;
  List<dynamic> successFortunes = [];

  final List<Widget> _pages = [
    const CoffeePage(),
    const TarotPage(),
    const ProfilePage(),
    const NotificationPage(),
    const ShopPage(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<DiamondService>(context, listen: false)
        .getDiamondAmount(currentUser!.uid)
        .then((value) => setState(() {
              _diamondAmount = value;
            }));
    setState(() {
      _selectedIndex = widget.initialPageIndex;
    });
  }

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
          leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$_diamondAmount', style: const TextStyle(fontSize: 19)),
                const Icon(Icons.diamond, size: 19),
              ]),
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
          initialActiveIndex: widget.initialPageIndex,
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
              icon: Icon(Icons.diamond),
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
