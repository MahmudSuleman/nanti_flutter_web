import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth < 700) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.8,
          child: child,
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
              vertical: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.6,
          child: child,
        );
      }
    });
  }
}
