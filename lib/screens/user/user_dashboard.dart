import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/dashboard_summary_service.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class UserDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    return FutureBuilder(
      future: DashboardSummaryService.userDashboardSummary(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            var dashboardData = snapShot.data as Map<String, dynamic>;
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
                      summary: '${dashboardData['dispatches']}',
                    ),
                    DashboardChip(
                      color: Colors.green,
                      title: 'Maintenance',
                      icon: Icons.settings,
                      summary: '${dashboardData['maintenances']}',
                    ),
                  ],
                ),
              ),
            ));
          } else {
            return Center(
              child: Text('NO DATA FOUND'),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
