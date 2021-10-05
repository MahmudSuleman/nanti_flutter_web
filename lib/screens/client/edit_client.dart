import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client.dart';
import 'package:nanti_flutter_web/models/client_type.dart';
import 'package:nanti_flutter_web/providers/client_type_provider.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditClient extends StatefulWidget {
  final Client company;

  EditClient(this.company);

  @override
  _EditClientState createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  String? selectedValue;

  String name = '';

  String type = '';

  String contact = '';

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    return Container(
      constraints: BoxConstraints(minWidth: 300, maxWidth: 1000),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Client'),
              kDivider(),
              TextFormField(
                initialValue: widget.company.name,
                decoration: kInputDecoration('Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  } else {
                    name = value;
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<ClientTypeProvider>(builder: (_, types, __) {
                return DropdownButtonFormField<String>(
                  value: selectedValue ?? widget.company.typeId,
                  decoration: kInputDecoration('Client Type'),
                  onChanged: (value) {
                    type = value!;
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  items: types.allClientTypes
                      .map(
                        (ClientType clientType) => DropdownMenuItem(
                          value: clientType.id,
                          child: Text(clientType.name),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Client type is required';
                    } else {
                      type = value;
                    }

                    return null;
                  },
                );
              }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.company.contact,
                decoration: kInputDecoration('Contact'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Contact is required';
                  } else {
                    contact = value;
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

                    var response = await ClientService.update(new Client(
                        id: widget.company.id,
                        name: name,
                        typeId: type,
                        contact: contact));

                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Company Updated Successfully')));
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to Updated Company')));
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          )),
    );
  }
}