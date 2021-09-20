import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_lg.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_md.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_sm.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_xl.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    required this.size,
    required this.child,
  });

  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
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
        child: child,
      );
    }
    if (kSmallScreenSize(screenWidth)) {
      return ResponsiveSm(
        child: child,
      );
    }

    return ResponsiveXl(
      child: child,
    );
  }
}
