import 'package:flutter/material.dart';

class ResponsiveMd extends StatelessWidget {
  final Widget child;

  const ResponsiveMd({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: child,
      ),
    );
  }
}
