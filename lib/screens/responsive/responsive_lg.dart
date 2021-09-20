import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/side_bar.dart';

class ResponsiveLg extends StatelessWidget {
  final Widget child;

  const ResponsiveLg({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: kAppBarBackground,
              child: SideBar(),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
