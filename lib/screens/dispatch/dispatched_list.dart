import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';

import '../../constants.dart';

class DispatchedList extends StatefulWidget {
  static String routeName = '/dispatched-device';
  @override
  _DispatchedListState createState() => _DispatchedListState();
}

class _DispatchedListState extends State<DispatchedList> {
  List<SelectItem> companyItems = [];

  Future<List<Dispatch>> _dispatchedDevices() async {
    List<Dispatch> allDispatches = await DispatchService.allDispatches();
    List<Dispatch> data = [];
    if (allDispatches.isNotEmpty) {
      for (var item in allDispatches) {
        data.add(item);
      }
    }

    return data;
  }

  @override
  void initState() {
    super.initState();

    CompanyService.allCompanies().then((companies) {
      companyItems =
          companies.map((e) => SelectItem(id: e.id, name: e.name)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      appBarTitle: 'Dispatched Devices',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Dispatched Devices",
              style: kPageHeaderTextStyle,
              textAlign: TextAlign.center,
            ),
            Divider(),
            SizedBox(height: 20),
            FutureBuilder(
              future: _dispatchedDevices(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  if (snapShot.hasData) {
                    var data = snapShot.data as List<Dispatch>;
                    var _tableHeader = [
                      'Company Name',
                      'Device Name',
                      'Action'
                    ];

                    return Container(
                      width: 1000,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTableWidget(
                          header: _tableHeader,
                          data: [
                            for (Dispatch item in data)
                              DataRow(cells: [
                                DataCell(Text(item.companyName)),
                                DataCell(Text(item.deviceName)),
                                DataCell(ElevatedButton(
                                  style: kElevatedButtonStyle(),
                                  child: Icon(
                                    Icons.cancel_schedule_send_outlined,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                'You are about to retrieve device!!'),
                                            actions: [
                                              ElevatedButton(
                                                style: kElevatedButtonStyle(
                                                    color: Colors.red.shade300),
                                                onPressed: () {
                                                  // TODO: make request to server
                                                  Navigator.pop(context, true);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                        'Device retrieved successfully',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text('Confirm'),
                                              ),
                                              ElevatedButton(
                                                style: kElevatedButtonStyle(
                                                  color: Colors.green.shade300,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                )),
                              ])
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          Text('No Data Found'),
                          Icon(Icons.event_note_sharp),
                        ],
                      ),
                    );
                  }
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
