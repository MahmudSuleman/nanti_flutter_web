import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
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

  @override
  void initState() {
    super.initState();

    ClientService.index().then((clients) {
      companyItems = clients
          .map((e) => SelectItem(id: e.id.toString(), name: e.name))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Responsive(
      appBarTitle: 'Dispatched Devices',
      child: SingleChildScrollView(
        child: Column(
          children: [
            kPageHeaderTitle('Dispatched Devices', size),
            Divider(),
            SizedBox(height: 20),
            FutureBuilder(
              future: DispatchService.allDispatches(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  if (snapShot.hasData) {
                    var data = snapShot.data as List<Dispatch>;
                    var _tableHeader = [
                      'Company Name',
                      'Device Name',
                      'Action'
                    ];

                    if (data.length > 0) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          width: 1000,
                          child: DataTableWidget(
                            header: _tableHeader,
                            data: [
                              for (Dispatch item in data)
                                DataRow(cells: [
                                  DataCell(Text(item.client!.name)),
                                  DataCell(Text(item.device!.name)),
                                  DataCell(_builActionButton(item)),
                                ])
                            ],
                          ),
                        ),
                      );
                    }

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

  ElevatedButton _builActionButton(item) => ElevatedButton(
        style: kElevatedButtonStyle(),
        child: Icon(
          Icons.cancel_schedule_send_outlined,
        ),
        onPressed: () async {
          await showDialog<bool?>(
            context: context,
            builder: (_) => _buildDialog(item),
          );
        },
      );

  AlertDialog _buildDialog(item) => AlertDialog(
        content: Text('You are about to retrieve device!!'),
        actions: [
          TextButton(
            onPressed: () async {
              var res = await DispatchService.retrieve(item.device!.id);
              if (res) {
                kSuccessSnackBar(context, 'Device Retrieved Successfully');
                kPopTrue(context);
                setState(() {});
              } else {
                kFailureSnackBar(context, 'Failed to retrieve device');
                kPopFalse(context);
              }
            },
            child: Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              kPopFalse(context);
              kFailureSnackBar(context, 'Cancelled');
            },
            child: Text('Cancel'),
          )
        ],
      );
}
