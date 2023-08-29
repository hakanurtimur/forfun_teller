import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';
import 'package:forfun_teller/screens/fortune_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
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

          return InsideScaffold(
            childWidget: Container(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: successFortunes != null
                  ? ListView.builder(
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
                                    );
                                  }));
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.white),
                              ),
                              leading: Icon(Icons.notifications),
                              title: Column(
                                children: [
                                  Text(successFortunes[index]['createdAt'] +
                                      ' saatinde gönderdiğiniz fal geldi.'),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            title: 'Fallarınız',
          );
        }
      },
    );
  }
}
