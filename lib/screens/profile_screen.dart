import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/auth_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Profil'),
      ),
      backgroundColor: Colors.transparent,
      body: user != null
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(user?.email ?? 'null'),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.photoURL ??
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    radius: 50,
                  ),
                  Text(user?.displayName ?? 'Henüz bir isim belirlemediniz'),
                  Text(user?.phoneNumber ?? 'Henüz bir telefon numarası yok'),
                ],
              ),
            )
          : Container(),
    );
  }
}
