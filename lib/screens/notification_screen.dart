import 'package:flutter/material.dart';
import 'package:forfun_teller/widgets/inside_scaffold.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InsideScaffold(
      childWidget: Container(
          child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
            ),
            title: Text('Başlık'),
            subtitle: Text('Alt Başlık'),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      )),
      title: 'Bildirimler',
    );
  }
}
