import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';

import '../../constants.dart';

class AvailableDispatch extends StatefulWidget {
  static String routeName = '/available-dispatch';

  @override
  _AvailableDispatchState createState() => _AvailableDispatchState();
}

class _AvailableDispatchState extends State<AvailableDispatch> {
  final _formKey = GlobalKey<FormState>();

  var _chosenValue;
  var _selectedCompany;

  List<SelectItem> companyItems = [];

  @override
  void initState() {
    super.initState();

    ClientService.allClients().then((clients) {
      companyItems = clients
          .map((e) => SelectItem(id: e.id.toString(), name: e.name))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Responsive(
        appBarTitle: 'Available Devices',
        child: SingleChildScrollView(
          child: Column(
            children: [
              kPageHeaderTitle('Available Devices', size),
              Divider(),
              SizedBox(height: 20),
              FutureBuilder(
                future: DispatchService.available(),
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

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: data.isEmpty
                            ? Center(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text('No Data Found'),
                                      Icon(Icons.event_note_sharp),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: 1000,
                                child: DataTableWidget(
                                  header: _tableHeader,
                                  data: [
                                    for (Device item in data)
                                      DataRow(
                                        cells: [
                                          DataCell(Text(item.serialNumber)),
                                          DataCell(Text(item.name)),
                                          DataCell(
                                              Text(item.manufacturerName!)),
                                          DataCell(
                                            ElevatedButton(
                                              style: kElevatedButtonStyle(),
                                              child: Icon(Icons.send),
                                              onPressed: () async {
                                                var res = await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: dispatchForm(
                                                            context, item),
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
                                ),
                              ),
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
          ),
        ));
  }

  Widget dispatchForm(BuildContext context, Device item) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Company',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          kDivider(),
          DropdownButtonFormField<String>(
            decoration: kInputDecoration('Select Company'),
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
          kDivider(),
          ElevatedButton(
            style: kElevatedButtonStyle(),
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
                                var body = jsonDecode(res.body)
                                    as Map<String, dynamic>;
                                if (body['success']) {
                                  Navigator.pop(context, true);
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

                if (res) {
                  Navigator.pop(context);
                  setState(() {
                    _chosenValue = null;
                    companyItems = [];
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Dispatch',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
