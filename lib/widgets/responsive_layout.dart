import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {required this.smallScreen,
      required this.mediumScreen,
      required this.largeScreen,
      required this.extraLargeScreen});

  static bool isSmallScreen(screenWidth) => screenWidth <= 500;
  static bool isMediumScreen(screenWidth) => screenWidth > 500;
  static bool isLargeScreen(screenWidth) => screenWidth > 900;
  static bool isExtraLargeScreen(screenWidth) => screenWidth > 1200;

  final Widget smallScreen;
  final Widget mediumScreen;
  final Widget largeScreen;
  final Widget extraLargeScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;

      if (isLargeScreen(screenWidth)) {
        return largeScreen;
      }

      if (isMediumScreen(screenWidth)) {
        return mediumScreen;
      }
      if (isSmallScreen(screenWidth)) {
        return smallScreen;
      }

      return extraLargeScreen;
    });
  }
}
