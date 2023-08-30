import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:forfun_teller/widgets/scaffolds/inside_scaffold.dart';
import 'package:forfun_teller/screens/fortune_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<List<Map<String, dynamic>>?>(
      stream: Provider.of<FortuneServices>(context)
          .getSuccessFortunesStream(currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SpinKitSpinningLines(color: Colors.white));
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>>? successFortunes = snapshot.data;
          if (successFortunes!.isEmpty) {
            return InsideScaffold(
              childWidget: const Center(child: Text('Henüz falınız yok')),
              title: 'Fallarınız',
            );
          } else {
            return InsideScaffold(
              childWidget: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 0, right: 0, bottom: 10),
                  child: ListView.builder(
                    itemCount: successFortunes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FortuneDetailPage(
                                    fortuneTitle: successFortunes[index]
                                        ['title'],
                                    fortuneText: successFortunes[index]
                                        ['fortuneText'],
                                    fortuneOwner: successFortunes[index]
                                        ['owner'],
                                  );
                                }));
                              },
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 20),
                            ),
                            leading: Column(
                              children: [
                                const Icon(Icons.notifications),
                                Text(
                                  successFortunes[index]['turnedAt'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                            title: Column(
                              children: [
                                Text(successFortunes[index]['createdDate'] +
                                    ' tarihli fal geldi.'),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  )),
              title: 'Fallarınız',
            );
          }
        }
      },
    );
  }
}
