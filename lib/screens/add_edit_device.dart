import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:nanti_flutter_web/widgets/text_input_widget.dart';

// ignore: must_be_immutable
class AddDevice extends StatefulWidget {
  static const routeName = '/add-device';

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final _formKey = GlobalKey<FormState>();

  String? deviceName;

  String? deviceSerialNumber;

  String? deviceManufacturer;

  bool isLoading = false;

  var id;
  var name;
  var serialNumber;
  var manufacturer;
  var header = 'Add New Device';
  var action = 'add';

  Device? device;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      args = args as Map<String, String>;
      id = args['id'];
      name = args['name'];
      manufacturer = args['manufacturer'];
      serialNumber = args['serialNumber'];
      header = 'Edit Device Details';
      action = args['action']!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(header),
      ),
      body: MainContainer(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    header.toUpperCase(),
                    style: kPageHeaderTextStyle,
                  ),
                  Divider(),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextInputWidget(
                          initValue: name != null ? name : null,
                          labelText: 'Device Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Device name is required';
                            } else {
                              deviceName = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextInputWidget(
                          initValue: serialNumber != null ? serialNumber : null,
                          labelText: 'Device Serail Number',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Device Serial Number is required';
                            } else {
                              deviceSerialNumber = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextInputWidget(
                          initValue: manufacturer != null ? manufacturer : null,
                          labelText: 'Device Manufacturer Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Device Manufacturer is required';
                            } else {
                              deviceManufacturer = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(

                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              action == 'add' ? _save() : _edit();
                               Navigator.pushNamed(context, DeviceList.routeName);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            minWidth: double.infinity,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      DeviceService.store(Device(
              id: '${DateTime.now()}',
              manufactuer: deviceManufacturer!,
              name: deviceName!,
              serialNumber: deviceSerialNumber!))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success'] == 'true') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data saved')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data not saved')));
        }
      });
    }
  }

  _edit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      DeviceService.update(Device(
              id: id,
              manufactuer: deviceManufacturer!,
              name: deviceName!,
              serialNumber: deviceSerialNumber!))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success'] == 'true') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data Updated')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data not Updated')));
        }
      });
    }
  }
}
