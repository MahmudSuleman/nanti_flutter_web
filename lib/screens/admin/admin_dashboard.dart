import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class AdminDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
        child: SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          runSpacing: 20,
          spacing: 15,
          children: [
            DashboardChip(
                color: Colors.yellow,
                title: 'Devices',
                icon: Icons.phone_android,
                summary: '24'),
            DashboardChip(
                color: Colors.green,
                title: 'Maintenance',
                icon: Icons.settings,
                summary: '24'),
            DashboardChip(
                color: Color.fromRGBO(20, 20, 20, 1),
                title: 'Companies',
                icon: Icons.house,
                summary: '24'),
            DashboardChip(
                color: Colors.pink,
                title: 'Companies',
                icon: Icons.house,
                summary: '24'),
          ],
        ),
      ),
    ));
  }
}
