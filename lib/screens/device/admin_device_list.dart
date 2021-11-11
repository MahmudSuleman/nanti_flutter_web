import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/manufacturer.dart';
import 'package:nanti_flutter_web/providers/manufacturer_provider.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';
import 'package:nanti_flutter_web/widgets/data_table_widget.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

/*

* TODO: fix page refresh when [add button is pressed, dropdown pressed, edit button pressed ]
TODO: replace snackbars messages pop up with a flutterToast widget
* 
 */
class AdminDeviceList extends StatefulWidget {
  const AdminDeviceList({Key? key}) : super(key: key);

  @override
  _AdminDeviceListState createState() => _AdminDeviceListState();
}

class _AdminDeviceListState extends State<AdminDeviceList> {
  List<String> _tableHeader = [
    'Serial Number',
    'Name',
    'Model',
    'Manufacturer',
    'Available',
    'Action'
  ];

  var isLoading;
  String? name;
  var serialNumber;
  int? manufacturerId;
  String? model;
  int? id;
  int? selectedValue;
  List<DropdownMenuItem<String>> dropdownItems = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    Provider.of<ManufacturerProvider>(context, listen: false).init();
    final size = MediaQuery.of(context).size.width;

    return Responsive(
      appBarTitle: 'Devices List',
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
                    kPageHeaderTitle('Devices List', size),
                    Divider(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: AddItemButton(
                        onPressed: () {
                          setState(() {
                            // selectedValue = null;
                            name = null;
                            manufacturerId = null;
                            model = null;
                            serialNumber = null;
                            id = null;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: addEditDeviceForm(false),
                                );
                              });
                        },
                      ),
                    ),
                    // addDevicesButton(context),
                    Divider(),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: data == null
                          ? Align(
                              alignment: Alignment.center,
                              child: Text('No data found'),
                            )
                          : Container(
                              width: 1000,
                              child: DataTableWidget(
                                header: _tableHeader,
                                data: _tableBody(data),
                              ),
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

  List<DataRow> _tableBody(List<Device> data) => data
      .map(
        (Device item) => DataRow(
          cells: [
            DataCell(Text(item.serialNumber)),
            DataCell(Text(item.name)),
            DataCell(Text(item.model)),
            DataCell(Text(item.manufacturer!.name)),
            DataCell(
              item.isAvailable == 1
                  ? Chip(
                      label: Text('Yes'),
                      backgroundColor: Colors.green,
                    )
                  : Chip(
                      label: Text('No '),
                      backgroundColor: Colors.red[100],
                    ),
            ),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    style: kElevatedButtonStyle(),
                    child: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        name = item.name;
                        manufacturerId = item.manufacturerId;
                        model = item.model;
                        serialNumber = item.serialNumber;
                        id = item.id;
                      });

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: addEditDeviceForm(true, id),
                            );
                          });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: kElevatedButtonStyle(color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            MaterialButton(
                              onPressed: () async {
                                var res = await DeviceService.destroy(item.id);
// todo: use flutter toast to display success messages
                                if (res) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Data deleted!')));
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to delete device data!')));
                                }
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
      .toList();

  //todo: extract to a widget
  addEditDeviceForm([bool isEditing = true, int? id]) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minWidth: 500),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isEditing ? 'Edit Device' : 'Add New Device'),
                kDivider(),
                TextFormField(
                  initialValue: serialNumber,
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
                  initialValue: name,
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
                  initialValue: model,
                  decoration: kInputDecoration('Device Model'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Model is Required';
                    } else {
                      setState(() {});
                      model = value;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<ManufacturerProvider>(
                    builder: (context, manufacturer, child) {
                  return DropdownButtonFormField<int>(
                    value: manufacturerId ?? selectedValue,
                    decoration: kInputDecoration('Manufacturer'),
                    items: manufacturer.allManufacturers.map((Manufacturer m) {
                      return DropdownMenuItem<int>(
                        value: m.id,
                        child: Text(m.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      manufacturerId = value!;
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  );
                }),
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
                    if (isEditing)
                      editDevice(id!);
                    else
                      addDevice();
                  },
                )
              ],
            )),
      ),
    );
  }

  addDevice() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      Device _device = Device(
        manufacturerId: manufacturerId!,
        name: name!,
        model: model!,
        serialNumber: serialNumber,
      );

      DeviceService.store(_device).then((value) {
        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Data saved')));
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to save data')));
          _formKey.currentState!.reset();
        }
      });
    }
  }

  editDevice(int id) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      DeviceService.update(
        Device(
          id: id,
          manufacturerId: manufacturerId!,
          name: name!,
          model: model!,
          serialNumber: serialNumber,
        ),
      ).then((value) {
        if (value.statusCode == 200) {
          kSuccessSnackBar(context, 'Data updated');
          Navigator.pop(context, true);
          setState(() {});
        } else {
          kFailureSnackBar(context, 'Data not Updated');
        }
      });
    }
  }
}
