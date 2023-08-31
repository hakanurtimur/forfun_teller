import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/services/provider/diamond_services.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:forfun_teller/widgets/scaffolds/inside_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/widgets/profile-widgets/profile_info_row.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  int? _diamondAmount;
  int? _fortuneAmount;

  @override
  initState() {
    super.initState();
    Provider.of<DiamondService>(context, listen: false)
        .getDiamondAmount(currentUser!.uid)
        .then((value) => setState(() {
              _diamondAmount = value;
            }));
    Provider.of<FortuneServices>(context, listen: false)
        .getFortuneAmount(currentUser!.uid)
        .then((value) => setState(() {
              _fortuneAmount = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      title: null,
      childWidget: Consumer<AuthServices>(
        builder: (context, authServices, child) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const PadderBox(),
                    const PadderBox(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage: NetworkImage(
                          currentUser!.photoURL ??
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                      ),
                    ),
                    ProfileInfoRow(
                      icon: Icons.person,
                      leadingText: 'İsim:',
                      trailingText: currentUser!.displayName,
                    ),
                    ProfileInfoRow(
                      icon: Icons.email,
                      leadingText: 'E-posta:',
                      trailingText: currentUser!.email,
                    ),
                    ProfileInfoRow(
                      icon: Icons.coffee,
                      leadingText: 'Kahve Falı Sayısı:',
                      trailingText: _fortuneAmount.toString(),
                    ),
                    const ProfileInfoRow(
                      icon: Icons.star,
                      leadingText: 'Çevrilen Tarot Sayısı:',
                      trailingText: '0',
                    ),
                    ProfileInfoRow(
                      icon: Icons.diamond,
                      leadingText: 'Forfun Diamond:',
                      trailingText: _diamondAmount.toString(),
                    ),
                    const PadderBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: kOutlinedButtonStyle,
                          onPressed: () {
                            Navigator.pushNamed(context, '/update_profile');
                          },
                          child: const Text(
                            'Profili Düzenle',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          style: kOutlinedButtonStyle.copyWith(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            await Provider.of<AuthServices>(context,
                                    listen: false)
                                .logout();
                            if (!context.mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          },
                          child: const Text(
                            'Çıkış Yap',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
