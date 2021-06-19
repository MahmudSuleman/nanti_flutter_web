import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:nanti_flutter_web/widgets/text_input_widget.dart';

// ignore: must_be_immutable
class AddEditDevice extends StatefulWidget {
  static const routeName = '/add-edit-device';

  @override
  _AddEditDeviceState createState() => _AddEditDeviceState();
}

class _AddEditDeviceState extends State<AddEditDevice> {
  final _formKey = GlobalKey<FormState>();

  // text input fields controllers
  final _deviceNameController = TextEditingController();
  final _deviceSerialNumberController = TextEditingController();
  final _deviceManufacturerController = TextEditingController();

  String deviceName = '';

  String deviceSerialNumber = '';

  String deviceManufacturer = '';

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

      _deviceManufacturerController.text = manufacturer;
      _deviceNameController.text = name;
      _deviceSerialNumberController.text = serialNumber;
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
            : Center(
                child: SingleChildScrollView(
                  child: Column(
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
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            TextInputWidget(
                              controller: _deviceNameController,
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
                              controller: _deviceSerialNumberController,
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
                              controller: _deviceManufacturerController,
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
              manufactuer: deviceManufacturer,
              name: deviceName,
              serialNumber: deviceSerialNumber))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data saved')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(body['message'])));
          _deviceManufacturerController.text = deviceManufacturer;
          _deviceNameController.text = deviceName;
          _deviceSerialNumberController.text = serialNumber;
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
              manufactuer: deviceManufacturer,
              name: deviceName,
              serialNumber: deviceSerialNumber))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        var body = jsonDecode(value.body);
        if (body['success']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data Updated')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data not Updated')));
        }
      });
    }
  }
}
