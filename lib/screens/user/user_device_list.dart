import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';
import 'package:nanti_flutter_web/services/maintenance_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class UserDeviceList extends StatefulWidget {
  const UserDeviceList({Key? key}) : super(key: key);
  static const routeName = '/user-device-list';

  @override
  _UserDeviceListState createState() => _UserDeviceListState();
}

class _UserDeviceListState extends State<UserDeviceList> {
  List<String> _tableHeader = [
    'Serial Number',
    'Name',
    'Manufacturer',
    'Action',
  ];

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
            future: DispatchService.userDispatches(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot.connectionState == ConnectionState.done) {
                late List<Map<String, dynamic>> data;
                if (snapShot.hasData) {
                  data = snapShot.data as List<Map<String, dynamic>>;
                  print('snapShot data: $data');
                }
                return Column(
                  children: [
                    Text(
                      "Devices List",
                      style: kPageHeaderTextStyle,
                      textAlign: TextAlign.center,
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
                                      (Map<String, dynamic> item) => DataRow(
                                        cells: [
                                          DataCell(Text(item['serialNumber'])),
                                          DataCell(Text(item['deviceName'])),
                                          DataCell(Text(item['manufacturer'])),
                                          DataCell(ElevatedButton(
                                            child: Icon(Icons.send),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Send Device'),
                                                      content: _popUpForm(
                                                          item['companyId'],
                                                          item['deviceId']),
                                                    );
                                                  });
                                            },
                                          )),
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

  final _problemDescCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Form _popUpForm(companyId, deviceId) => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Problem Description'),
              controller: _problemDescCtrl,
              validator: (value) {
                if (value == null) {
                  return 'Problem description is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final problemDescription = _problemDescCtrl.text;
                    MaintenanceService.store(
                            companyId, deviceId, problemDescription)
                        .then((value) {
                      if (value['success']) {
                        Navigator.pop(context);
                        _problemDescCtrl.text = '';
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Device sent successfully')));
                      } else {
                        _problemDescCtrl.text = '';
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value['message'])));
                      }
                    }).catchError((onError) {
                      print(onError.toString());
                    });
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      );
}
