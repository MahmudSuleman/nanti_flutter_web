import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String navUrl;
  final IconData iconName;
  final String iconLabel;
  const MenuItem({
    required this.navUrl,
    required this.iconName,
    required this.iconLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      leading: Icon(iconName),
      title: Text(iconLabel),
      onTap: () {
        Navigator.pushReplacementNamed(context, navUrl);
      },
      tileColor: Colors.white,
    );
  }
}
