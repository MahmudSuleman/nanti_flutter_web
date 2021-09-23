import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_lg.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_md.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_sm.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_xl.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  final String? appBarTitle;

  const Responsive({
    required this.child,
    this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return buildResponsive(size);
  }

  buildResponsive(double screenWidth) {
    if (kLargeScreenSize(screenWidth)) {
      return ResponsiveLg(
        child: child,
      );
    }

    if (kMediumScreenSize(screenWidth)) {
      return ResponsiveMd(
        appBarTitle: appBarTitle!,
        child: child,
      );
    }
    if (kSmallScreenSize(screenWidth)) {
      return ResponsiveSm(
        child: child,
        appBarTitle: appBarTitle,
      );
    }

    return ResponsiveXl(
      child: child,
    );
  }
}
