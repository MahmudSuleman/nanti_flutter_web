import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/top_grid.dart';
import 'package:nanti_flutter_web/services/dashboard_summary_service.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';

class UserTopGrid extends StatelessWidget {
  final perRowCount;
  const UserTopGrid({required this.perRowCount});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DashboardSummaryService.userDashboardSummary(),
        builder: (builder, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            final dashboardData = snapShot.data as Map<String, dynamic>;

            return TopGrid(
                perRowCount: perRowCount,
                itemsCount: 3,
                mainGap: 20,
                chips: [
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
                  DashboardChip(
                    color: Colors.green,
                    title: 'Users',
                    icon: Icons.person,
                    summary: '${dashboardData['users']}',
                  ),
                ]);
          }
          return CircularProgressIndicator();
        });
  }
}
