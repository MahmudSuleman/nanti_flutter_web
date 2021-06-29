import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/screens/add_edit_device.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';
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
    'Available',
    'Action'
  ];

  Future<List<Device>> deviceFromServer() async {
    return await DeviceService.allDevices();
  }

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices List'),
      ),
      body: MainContainer(
          child: SingleChildScrollView(
        child: FutureBuilder(
            future: DeviceService.allDevices(),
            builder: (context, asyncsnapshot) {
              if (asyncsnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (asyncsnapshot.connectionState ==
                  ConnectionState.done) {
                List<Device>? data;
                if (asyncsnapshot.hasData) {
                  data = asyncsnapshot.data as List<Device>;
                }
                return Column(
                  children: [
                    Text(
                      "Devices List",
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
                                      context, AddEditDevice.routeName)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {});
                                }
                              });
                            },
                            child: Text('Add a Device'),
                          ),
                        )),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        // scroll direction reduces the width
                        // that's why media query is used instead
                        scrollDirection: MediaQuery.of(context).size.width > 600
                            ? Axis.vertical
                            : Axis.horizontal,
                        child: data == null
                            ? Align(
                                alignment: Alignment.center,
                                child: Text('No data found'))
                            : DataTableWidget(
                                header: _tableHeader,
                                data: data
                                    .map(
                                      (Device item) => DataRow(
                                        cells: [
                                          DataCell(Text(item.serialNumber)),
                                          DataCell(Text(item.name)),
                                          DataCell(Text(item.manufactuer)),
                                          DataCell(
                                            item.isAvailable == '1'
                                                ? Chip(
                                                    label: Text('Yes'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  )
                                                : Chip(
                                                    label: Text('No '),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                  ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        AddEditDevice.routeName,
                                                        arguments: {
                                                          'action': 'edit',
                                                          'id': item.id,
                                                          'name': item.name,
                                                          'manufacturer':
                                                              item.manufactuer,
                                                          'serialNumber':
                                                              item.serialNumber
                                                        }).then((value) {
                                                      if (value != null) {
                                                        setState(() {});
                                                      }
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
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: Text(
                                                            'Are you sure you want to delete this item?'),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              var res =
                                                                  await DeviceService
                                                                      .destroy(
                                                                          item.id);

                                                              if (res) {
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text('Data deleted!')));
                                                              } else {
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text('Failed to delete device data!')));
                                                              }
                                                            },
                                                            // color: Colors.red,
                                                            child: Text('Yes'),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            // color: Colors.red,
                                                            child: Text('No'),
                                                          )
                                                        ],
                                                      ),
                                                    ).then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                    )
                  ],
                );
              }
              return Text('nothing');
            }),
      )),
    );
  }
}
