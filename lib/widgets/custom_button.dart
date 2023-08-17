import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonTitle;
  final Function onPressFunc;
  final bool isNeedIcon;

  CustomButton({
    required this.buttonTitle,
    required this.onPressFunc,
    required this.isNeedIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).colorScheme.onBackground),
            padding: const EdgeInsets.all(5),
          ),
          onPressed: () {
            onPressFunc();
          },
          child: ListTile(
            leading: isNeedIcon
                ? const Hero(
                    tag: 'icon',
                    child: Image(
                      width: 30,
                      height: 30,
                      image: AssetImage('images/icon.png'),
                    ),
                  )
                : null,
            title: buttonTitle,
          )),
    );
  }
}
