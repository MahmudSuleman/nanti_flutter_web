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

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double size = constraints.maxWidth;
      print('size: $size');
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          horizontalTitleGap: 0.0,
          leading: Icon(iconName),
          title: Text(
            iconLabel,
            style: TextStyle(
              fontSize: size > 180 ? 15 : 10,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, navUrl);
          },
          tileColor: Colors.white,
        ),
      );
    });
  }
}
