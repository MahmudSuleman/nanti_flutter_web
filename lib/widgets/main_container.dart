import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth < 400) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          // height: MediaQuery.of(context).size.height,
          child: child,
        );
      } else if (constraint.maxWidth <= 1200) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          child: child,
        );
      } else if (constraint.maxWidth < 1500) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.9,
          // height: MediaQuery.of(context).size.height,
          child: child,
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.9,
          // height: MediaQuery.of(context).size.height,
          child: child,
        );
      }
    });
  }
}
