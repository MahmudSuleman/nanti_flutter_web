import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/screens/add_edit_device.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);
  static const routeName = '/device-list';

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<String> _tableHeader = [
    'Serial Number',
    'Name',
    'Manufacturer',
    'Action'
  ];

  Future<List<Device>> deviceFromServer() async {
    return await DeviceService.allDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Lists'),
      ),
      body: MainContainer(
          child: FutureBuilder(
              future: deviceFromServer(),
              builder: (context, asyncsnapshot) {
                if (asyncsnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (asyncsnapshot.connectionState ==
                    ConnectionState.done) {
                  return Column(
                    children: [
                      Text(
                        "Device List",
                        style: kPageHeaderTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddEditDevice.routeName);
                                },
                                child: Text('Add a Device')),
                          )),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          // scroll direction reduces the width
                          // that's why i am using media query
                          scrollDirection:
                              MediaQuery.of(context).size.width > 600
                                  ? Axis.vertical
                                  : Axis.horizontal,
                          child: _buildTable(data: asyncsnapshot.data),
                        ),
                      )
                    ],
                  );
                }
                return Text('nothing');
              })),
    );
  }

  _buildTable({data}) {
    return data == null
        ? Center(
            child: Text('No data found'),
          )
        : SingleChildScrollView(
            child: DataTable(
                columns: _tableHeader
                    .map((e) => DataColumn(label: Text(e)))
                    .toList(),
                rows: [
                  for (Device item in data)
                    DataRow(cells: [
                      DataCell(Text(item.serialNumber)),
                      DataCell(Text(item.name)),
                      DataCell(Text(item.manufactuer)),
                      DataCell(Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AddEditDevice.routeName,
                                  arguments: {
                                    'action': 'edit',
                                    'id': item.id,
                                    'name': item.name,
                                    'manufacturer': item.manufactuer,
                                    'serialNumber': item.serialNumber
                                  });
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                            'Are you sure you want to delete this item?'),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Data deleted!')));
                                            },
                                            // color: Colors.red,
                                            child: Text('Yes'),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            // color: Colors.red,
                                            child: Text('No'),
                                          )
                                        ],
                                      ));
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      )),
                    ])
                ]),
          );
  }
}
