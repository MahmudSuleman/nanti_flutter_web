import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/top_grid.dart';
import 'package:nanti_flutter_web/services/dashboard_summary_service.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';

class AdminTopGrid extends StatelessWidget {
  final perRowCount;

  const AdminTopGrid({required this.perRowCount});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DashboardSummaryService.adminDashboardSummary(),
        builder: (builder, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            final dashboardData = snapShot.data as Map<String, dynamic>;
            return TopGrid(
                perRowCount: perRowCount,
                itemsCount: 4,
                mainGap: 20,
                chips: [
                  DashboardChip(
                    color: Colors.yellow.shade200,
                    title: 'Devices',
                    icon: Icons.phone_android,
                    summary: '${dashboardData['devices']}',
                  ),
                  DashboardChip(
                    color: Colors.green.shade200,
                    title: 'Maintenance',
                    icon: Icons.settings,
                    summary: '${dashboardData['maintenances']}',
                  ),
                  DashboardChip(
                    color: Color.fromRGBO(20, 20, 20, 1),
                    title: 'Companies',
                    icon: Icons.house,
                    summary: '${dashboardData['companies']}',
                  ),
                  DashboardChip(
                    color: Colors.pink.shade200,
                    title: 'Dispatches',
                    icon: Icons.send,
                    summary: '${dashboardData['dispatches']}',
                  ),
                ]);
          }
          return CircularProgressIndicator();
        });
  }
}
