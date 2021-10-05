import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/company.dart';
import 'package:nanti_flutter_web/services/company_service.dart';

// ignore: must_be_immutable
class AddClient extends StatelessWidget {
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
              Text('Add Client'),
              kDivider(),
              TextFormField(
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
              TextFormField(
                decoration: kInputDecoration('Client Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Client type is required';
                  } else {
                    type = value;
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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

                    var response = await CompanyService.store(new Company(
                        id: '${DateTime.now()}',
                        name: name,
                        type: type,
                        contact: contact));

                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Client Added Successfully')));
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to Updated Client')));
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
