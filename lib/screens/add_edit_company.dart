import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/company.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:nanti_flutter_web/widgets/text_input_widget.dart';

class AddEditCompany extends StatefulWidget {
  static const routeName = '/add-edit-company';

  @override
  _AddEditCompanyState createState() => _AddEditCompanyState();
}

class _AddEditCompanyState extends State<AddEditCompany> {
  // set up controllers
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _contactController = TextEditingController();

  // form key
  var _formKey = GlobalKey<FormState>();

// temp variables
  var name;
  var type;
  var contact;
  var id;

  bool isLoading = false;

// config data
  String header = 'Add New Company';
  String action = 'add';

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      args = args as Map<String, String>;
      id = args['id'];
      name = args['name'];
      type = args['type'];
      contact = args['contact'];

      header = 'Edit Company Details';
      action = 'edit';

      _nameController.text = name;
      _typeController.text = type;
      _contactController.text = contact;
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
                        child: Column(
                          children: [
                            TextInputWidget(
                              controller: _nameController,
                              labelText: 'Company Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Company Name is Required';
                                } else {
                                  name = value;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextInputWidget(
                              controller: _typeController,
                              labelText: 'Company Type',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Company Type is Required';
                                } else {
                                  type = value;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextInputWidget(
                              controller: _contactController,
                              labelText: 'COmpany Contact',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Company Contact is Required';
                                } else {
                                  contact = value;
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
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
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

      CompanyService.store(Company(
              id: '${DateTime.now()}',
              name: name,
              type: type,
              contact: contact))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.statusCode == 200) {
          var body = jsonDecode(value.body);
          if (body['success']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Data Saved')));
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(body['message'])));
          }
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

      CompanyService.update(
              Company(id: id, name: name, type: type, contact: contact))
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.statusCode == 200) {
          var body = jsonDecode(value.body);
          if (body['success']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Data Updated')));
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Data not Updated')));
          }
        }
      });
    }
  }
}
