import 'package:flutter/material.dart';

class ResponsiveSm extends StatelessWidget {
  const ResponsiveSm({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
