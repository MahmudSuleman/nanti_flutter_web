import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';

import '../../constants.dart';

class AdminDeviceList extends StatefulWidget {
  const AdminDeviceList({Key? key}) : super(key: key);

  @override
  _AdminDeviceListState createState() => _AdminDeviceListState();
}

class _AdminDeviceListState extends State<AdminDeviceList> {
  List<String> _tableHeader = [
    'Serial Number',
    'Name',
    'Manufacturer',
    'Available',
    'Action'
  ];

  var isLoading;
  var name;
  var serialNumber;
  var manufacturer;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    final size = MediaQuery.of(context).size.width;

    return Responsive(
      appBarTitle: 'Devices List',
      size: size,
      child: FutureBuilder(
          future: DeviceService.allDevices(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              List<Device>? data;
              if (snapShot.hasData) {
                data = snapShot.data as List<Device>;
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Devices List",
                      style: kPageHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    addDevicesButton(context),
                    Divider(),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                                                  backgroundColor: Colors.green,
                                                )
                                              : Chip(
                                                  label: Text('No '),
                                                  backgroundColor:
                                                      Colors.red[100],
                                                ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                style: kElevatedButtonStyle(),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content:
                                                              addEditDeviceForm(),
                                                        );
                                                      });
                                                },
                                                child: Icon(Icons.edit),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                style: kElevatedButtonStyle(
                                                    color: Colors.red),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      content: Text(
                                                          'Are you sure you want to delete this item?'),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            var res =
                                                                await DeviceService
                                                                    .destroy(
                                                                        item.id);

                                                            if (res) {
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text('Data deleted!')));
                                                            } else {
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
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
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Align addDevicesButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            style: kElevatedButtonStyle(),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: addEditDeviceForm(),
                    );
                  });
            },
            child: Text('Add a Device'),
          ),
        ));
  }

  addEditDeviceForm() {
    return Container(
      constraints: BoxConstraints(minWidth: 500),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Device'.toUpperCase()),
              kDivider(),
              TextFormField(
                decoration: kInputDecoration('Serial Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Serial Number is Required';
                  } else {
                    setState(() {
                      serialNumber = value;
                    });
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: kInputDecoration('Device Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Device Name is Required';
                  } else {
                    setState(() {});
                    name = value;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: kInputDecoration('Manufacturer Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Device Manufacturer is Required';
                  } else {
                    setState(() {
                      manufacturer = value;
                    });
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              kDivider(),
              ElevatedButton(
                style: kElevatedButtonStyle(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  addDevice();
                },
              )
            ],
          )),
    );
  }

  addDevice() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      DeviceService.store(Device(
              id: '${DateTime.now()}',
              manufactuer: manufacturer,
              name: name,
              serialNumber: serialNumber))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data saved')));
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(body['message'])));
          _formKey.currentState!.reset();
        }
      });
    }
  }

  editDevice(
      {required String id,
      required String name,
      required String manufacturer,
      required String serialNumber}) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      DeviceService.update(Device(
              id: id,
              manufactuer: manufacturer,
              name: name,
              serialNumber: serialNumber))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data Updated')));
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data not Updated')));
        }
      });
    }
  }
}
