import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/side_bar.dart';

import '../../constants.dart';

class ResponsiveMd extends StatelessWidget {
  final Widget child;
  final String appBarTitle;

  const ResponsiveMd({required this.child, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kScaffoldBackground,
      body: child,
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: kAppBarBackground,
      ),
      drawer: Drawer(
        child: Container(
          color: kAppBarBackground,
          child: SideBar(),
        ),
      ),
    );
  }
}
