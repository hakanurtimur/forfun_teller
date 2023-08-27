import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/auth_services.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/widgets/profile_info_row.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthServices>(context, listen: false).currentUser == null) {
      Navigator.pushNamed(context, '/login');
    }
    return InsideScaffold(
      title: '',
      childWidget: Consumer<AuthServices>(
        builder: (context, authServices, child) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.only(bottom: 20),
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
                        authServices.currentUser!.photoURL ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      ),
                    ),
                  ),
                  ProfileInfoRow(
                    icon: Icons.person,
                    leadingText: 'İsim:',
                    trailingText: authServices.currentUser!.displayName,
                  ),
                  ProfileInfoRow(
                    icon: Icons.email,
                    leadingText: 'E-posta:',
                    trailingText: authServices.currentUser!.email,
                  ),
                  const ProfileInfoRow(
                    icon: Icons.coffee,
                    leadingText: 'Kahve Falı Sayısı:',
                    trailingText: '3',
                  ),
                  const ProfileInfoRow(
                    icon: Icons.star,
                    leadingText: 'Çevrilen Tarot Sayısı:',
                    trailingText: '4',
                  ),
                  const ProfileInfoRow(
                    icon: Icons.diamond,
                    leadingText: 'Forfun Diamond:',
                    trailingText: '4',
                  ),
                  const SizedBox(height: 30),
                  OutlinedButton(
                    style: kOutlinedButtonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, '/update_profile');
                    },
                    child: Text(
                      'Profili Düzenle',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  OutlinedButton(
                    style: kOutlinedButtonStyle,
                    onPressed: () async {
                      await Provider.of<AuthServices>(context, listen: false)
                          .logout();
                      await Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      'Çıkış Yap',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
