import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:nanti_flutter_web/widgets/text_input_widget.dart';

// ignore: must_be_immutable
class AddDevice extends StatelessWidget {
  static const routeName = '/add-device';

  final _formKey = GlobalKey<FormState>();

  String? deviceName;

  String? deviceSerialNumber;

  String? deviceManiufacturer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Device'),
      ),
      body: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add New Device'.toUpperCase(),
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
                    labelText: 'Device Manufacturer Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Device Manufacturer is required';
                      } else {
                        deviceManiufacturer = value;
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
                        _save();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 25, color: Colors.white),
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
      print('data valid');
    }
  }
}
