import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class DispatchList extends StatefulWidget {
  static const routeName = '/dispatch-list';
  @override
  _DispatchListState createState() => _DispatchListState();
}

class _DispatchListState extends State<DispatchList> {
  var _formKey = GlobalKey<FormState>();
  var _selectedCompany;
  var _chosenValue;

  List<SelectItem> companyItems = [];
  Future<List<Device>> _availableDevices() async {
    List<Device> allDevices = await DeviceService.allDevices();

    List<Device> data = [];
    if (allDevices.isNotEmpty) {
      for (var item in allDevices) {
        if (item.isAvailable == '1') data.add(item);
      }
    }

    return data;
  }

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Dispatched Devices'),
            bottom: TabBar(
              tabs: [
                tabHeader('Available Devices'),
                tabHeader('Dispatched Devices'),
              ],
            ),
          ),
          body: MainContainer(
              child: TabBarView(
            children: [
              FutureBuilder(
                future: _availableDevices(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      var data = snapShot.data as List<Device>;
                      var _tableHeader = [
                        'Serial Number',
                        'Device Name',
                        'Device Manufacturer',
                        'Action'
                      ];

                      return DataTableWidget(
                        header: _tableHeader,
                        data: [
                          for (Device item in data)
                            DataRow(
                              cells: [
                                DataCell(Text(item.serialNumber)),
                                DataCell(Text(item.name)),
                                DataCell(Text(item.manufactuer)),
                                DataCell(
                                  ElevatedButton(
                                    child: Icon(Icons.send),
                                    onPressed: () async {
                                      var res = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Please Select Company To Dispatch Device'),
                                              content:
                                                  dispatchForm(context, item),
                                            );
                                          });

                                      if (res != null) {
                                        Navigator.pop(context);
                                        // setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      );
                    } else {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
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

                      return DataTableWidget(
                        header: _tableHeader,
                        data: [
                          for (Dispatch item in data)
                            DataRow(cells: [
                              DataCell(Text(item.companyName)),
                              DataCell(Text(item.deviceName)),
                              DataCell(ElevatedButton(
                                child: Icon(
                                  Icons.cancel_schedule_send_outlined,
                                ),
                                onPressed: () {},
                              )),
                            ])
                        ],
                      );
                    } else {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ))),
    );
  }

  Widget dispatchForm(BuildContext context, Device item) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: companyItems
                .map(
                  (selectItem) => DropdownMenuItem<String>(
                    value: '${selectItem.id}',
                    child: Text('${selectItem.name}'),
                  ),
                )
                .toList(),

            hint: Text(
              'Select Company',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (String? value) {
              setState(() {
                _chosenValue = value!;
                companyItems = [];
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select company';
              } else {
                _selectedCompany = value;
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                var res = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Are you sure you want to dispatch this device?'),
                        actions: [
                          MaterialButton(
                            onPressed: () async {
                              var res = await DispatchService.store({
                                'deviceId': item.id,
                                'companyId': _selectedCompany
                              });

                              if (res.statusCode == 200) {
                                print(res.body);
                                var body = jsonDecode(res.body)
                                    as Map<String, dynamic>;
                                if (body['success']) {
                                  Navigator.pop(context, true);
                                  print('confirm dialog must pop');
                                  // setState(
                                  //     () {});
                                }
                              }
                            },
                            child: Text('Yes'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    });

                if (res != null) {
                  Navigator.pop(context);
                  print('form popup must pop');
                  setState(() {
                    _chosenValue = null;
                    companyItems = [];
                  });
                }
              }
            },
            child: Text(
              'Dispatch',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Text tabHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
