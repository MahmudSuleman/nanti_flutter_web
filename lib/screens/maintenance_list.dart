import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/maintenance_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class MaintenanceList extends StatelessWidget {
  static String routeName = '/maintenance-list';
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);

    List<String> _tableHeader = [
      'Date',
      'Device Name',
      'Company Name',
      'Problem Description',
      'Action',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance'),
      ),
      body: MainContainer(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: MaintenanceService.allMaintenance(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  List<Maintenance>? maintenance;
                  if (snapShot.hasData) {
                    maintenance = snapShot.data as List<Maintenance>;
                  }
                  return Column(
                    children: [
                      Text(
                        'Maintenance List',
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
                          child: maintenance == null
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
                                                '${maintenance.companyName}')),
                                            DataCell(Text(
                                                '${maintenance.problemDescription}')),
                                            DataCell(Text('actions')),
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
