import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/maintenance/admin_maintenance_list.dart';
import 'package:nanti_flutter_web/screens/maintenance/user_maintenance_list.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

class MaintenanceList extends StatelessWidget {
  static String routeName = '/maintenance-list';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.isAdmin(),
      builder: (builder, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return snapShot.data as bool
              ? AdminMaintenanceList()
              : UserMaintenanceList();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
