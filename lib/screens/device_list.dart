import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/providers/device_provider.dart';
import 'package:nanti_flutter_web/screens/add_device.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:provider/provider.dart';

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

  var _devices = [];
  @override
  Widget build(BuildContext context) {
    _devices = Provider.of<DeviceProvider>(context, listen: false).devices;
    print('building...');
    DeviceService()
        .allDevices()
        .then((_) => print('service done'))
        .catchError((onError) {
      print(onError);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Lists'),
      ),
      body: SingleChildScrollView(
        child: MainContainer(
          child: Column(
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
                          Navigator.pushNamed(context, AddDevice.routeName);
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
                  // thats why i am using media query
                  scrollDirection: MediaQuery.of(context).size.width > 600
                      ? Axis.vertical
                      : Axis.horizontal,
                  child: DataTable(
                      columns: _tableHeader
                          .map((e) => DataColumn(label: Text(e)))
                          .toList(),
                      rows: [
                        for (Device item in _devices)
                          DataRow(cells: [
                            DataCell(Text(item.serialNumber)),
                            DataCell(Text(item.name)),
                            DataCell(Text(item.manufactuer)),
                            DataCell(Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AddDevice.routeName,
                                        arguments: {
                                          'action': 'edit',
                                          'id': item.id
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
                                                    ScaffoldMessenger.of(
                                                            context)
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Table(
//               children: [
//                 TableRow(
//                   children: [
//                     for (var item in _tableHeader)
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           item,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 for (Device item in _devices)
//                   TableRow(
//                     decoration: Decoration,
//                     children: [
//                       TableCell(
//                         child: Text(item.serialNumber),
//                       ),
//                       TableCell(
//                         child: Text(item.name),
//                       ),
//                       TableCell(
//                         child: Text(item.manufactuer),
//                       ),
//                       TableCell(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Edit'),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Delete'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             )