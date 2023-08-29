import 'package:flutter/material.dart';
import 'package:forfun_teller/services/provider/fortune_services.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfun_teller/screens/fortune_detail_screen.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  List<dynamic>? successFortunes = [];

  void settingSuccessFortunes() async {
    var fortunes = await Provider.of<FortuneServices>(context, listen: false)
        .getSuccessFortunes(currentUser!.uid);
    setState(() {
      successFortunes = fortunes;
    });
  }

  @override
  void initState() {
    super.initState();
    settingSuccessFortunes();
  }

  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      childWidget: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: successFortunes != null
            ? ListView.builder(
                itemCount: successFortunes!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        trailing: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FortuneDetailPage(
                                fortuneTitle: successFortunes![index]['title'],
                                fortuneText: successFortunes![index]
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
                            Text(successFortunes![index]['createdAt'] +
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
}
