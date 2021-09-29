import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/maintenance_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';

class AdminMaintenanceList extends StatefulWidget {
  @override
  _AdminMaintenanceListState createState() => _AdminMaintenanceListState();
}

class _AdminMaintenanceListState extends State<AdminMaintenanceList> {
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    final size = MediaQuery.of(context).size.width;

    List<String> _tableHeader = [
      'Date',
      'Device Name',
      'Company Name',
      'Problem Description',
      'Status',
      'Action',
    ];
    return Responsive(
      appBarTitle: 'Maintenance List',
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
                    kPageHeaderTitle('Maintenance List', size),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 1000,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: maintenance!.isEmpty
                            ? Center(
                                child: Text('No data found'),
                              )
                            : Container(
                                width: 1000,
                                child: DataTableWidget(
                                  header: _tableHeader,
                                  data: maintenance
                                      .map(
                                        (Maintenance maintenance) => DataRow(
                                          cells: [
                                            DataCell(Text(
                                                '${maintenance.dateSent}')),
                                            DataCell(Text(
                                                '${maintenance.deviceName}')),
                                            DataCell(Text(
                                                '${maintenance.companyName}')),
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
                                            DataCell(
                                              maintenance.isDone == '1'
                                                  ? Container()
                                                  : ElevatedButton(
                                                      style:
                                                          kElevatedButtonStyle(),
                                                      child: Icon(Icons.send),
                                                      onPressed: () {
                                                        //mark device as done
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Mark as done'),
                                                              content: Text(
                                                                  'Are you sure you want to mark this device as done?'),
                                                              actions: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    _markAsDone(
                                                                        maintenance
                                                                            .id);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'Yes'),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'No'),
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: Center(child: CircularProgressIndicator()),
              );
            }),
      ),
    );
  }

  void _markAsDone(id) => MaintenanceService.markAsDone(id).then((value) {
        if (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Device marked as done')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to marked Device as done')));
        }

        setState(() {});
      });
}
