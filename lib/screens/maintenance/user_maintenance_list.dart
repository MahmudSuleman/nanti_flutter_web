import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/maintenance_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';

class UserMaintenanceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);

    List<String> _tableHeader = [
      'Date',
      'Device Name',
      'Problem Description',
      'Status',
    ];
    return Scaffold(
      body: Responsive(
        appBarTitle: 'Maintenace',
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: MaintenanceService.allUserMaintenance(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  late List<Maintenance> maintenance;
                  if (snapShot.hasData) {
                    maintenance = snapShot.data as List<Maintenance>;
                  }
                  return Column(
                    children: [
                      Text(
                        'Maintenance History',
                        style: kPageHeaderTextStyle,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          // scroll direction reduces the width
                          // that's why media query is used instead
                          scrollDirection:
                              MediaQuery.of(context).size.width > 600
                                  ? Axis.vertical
                                  : Axis.horizontal,
                          child: maintenance.isEmpty
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text('No data found'),
                                )
                              : DataTableWidget(
                                  header: _tableHeader,
                                  data: maintenance
                                      .map((Maintenance maintenance) =>
                                          DataRow(cells: [
                                            DataCell(Text(
                                                '${maintenance.dateSent}')),
                                            DataCell(Text(
                                                '${maintenance.deviceName}')),
                                            DataCell(Text(
                                                '${maintenance.problemDescription}')),
                                            maintenance.isDone == '1'
                                                ? DataCell(Chip(
                                                    label: Text('Done'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ))
                                                : DataCell(Chip(
                                                    label: Text('Pending'),
                                                    backgroundColor:
                                                        Colors.yellow,
                                                  )),
                                          ]))
                                      .toList(),
                                ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
