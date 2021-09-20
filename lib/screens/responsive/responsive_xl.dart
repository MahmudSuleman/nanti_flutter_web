import 'package:flutter/material.dart';

class ResponsiveXl extends StatelessWidget {
  final Widget child;

  const ResponsiveXl({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Responsive xl'),
    );
  }
}
