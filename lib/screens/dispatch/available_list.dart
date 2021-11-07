import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';

import '../../constants.dart';

class AvailableDispatch extends StatefulWidget {
  static String routeName = '/available-dispatch';

  @override
  _AvailableDispatchState createState() => _AvailableDispatchState();
}

class _AvailableDispatchState extends State<AvailableDispatch> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  var _chosenValue;
  int? _selectedClient;
  var _dispatchedNote;

  List<SelectItem> clientItems = [];

  @override
  void initState() {
    super.initState();

    ClientService.index().then((clients) {
      clientItems = clients
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
                            : DataTable(
                                columns: _tableHeader
                                    .map((e) => DataColumn(label: Text(e)))
                                    .toList(),
                                rows: [
                                  for (Device device in data)
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(device.serialNumber),
                                        ),
                                        DataCell(
                                          Text(device.name),
                                        ),
                                        DataCell(
                                          Text(device.manufacturer!.name),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            style: kElevatedButtonStyle(),
                                            child: Icon(Icons.send),
                                            onPressed: () async {
                                              var res = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content:
                                                          dispatchForm(device),
                                                    );
                                                  });

                                              if (res != null) {
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                ],
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

  Widget dispatchForm(Device item) {
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
          buildDropDown(clientItems),
          SizedBox(height: 10),
          buildDateField(),
          SizedBox(height: 10),
          TextFormField(
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Dispatch note is required'
                  : null;
            },
            onSaved: (value) {
              _dispatchedNote = value;
            },
            decoration: kInputDecoration('Dispatch note'),
          ),
          kDivider(),
          ElevatedButton(
            style: kElevatedButtonStyle(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Dispatch',
                style: TextStyle(fontSize: 20),
              ),
            ),
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
                              var res = await DispatchService.store(
                                Dispatch(
                                    clientId: _selectedClient!,
                                    date: _dateController.text,
                                    deviceId: item.id!,
                                    note: _dispatchedNote),
                              );

                              if (res) {
                                Navigator.pop(context, true);
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

                if (res != null && res) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Device dispatched successfully'),
                  ));
                  setState(() {
                    _chosenValue = null;
                    clientItems = [];
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }

  buildDateField() {
    return TextFormField(
      controller: _dateController,
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1),
        );

        if (date != null) {
          _dateController.text = kFormatDate(date);
          // '${date.day}-${date.month}-${date.year}';
        }
      },
      decoration: kInputDecoration('Note Date'),
      validator: (value) {
        return value == null || value.isEmpty ? 'Date is required' : null;
      },
    );
  }

  buildDropDown(List<SelectItem> items) {
    return DropdownButtonFormField<int>(
      decoration: kInputDecoration('Select Company'),
      value: _chosenValue,
      style: TextStyle(color: Colors.black),
      items: clientItems
          .map(
            (selectItem) => DropdownMenuItem<int>(
              value: int.parse(selectItem.id!),
              child: Text('${selectItem.name}'),
            ),
          )
          .toList(),
      onChanged: (int? value) {
        setState(() {
          _chosenValue = value!;
          clientItems = [];
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select company';
        } else {
          _selectedClient = value;
        }
        return null;
      },
    );
  }
}
