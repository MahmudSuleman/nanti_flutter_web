import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/models/user.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/user_service.dart';

class UserList extends StatefulWidget {
  static final String routeName = '/user-list';

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _formKey = GlobalKey<FormState>();
  List<SelectItem> companyItems = [];
  String? _currentCompany;
  bool isLoading = false;

  //controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ClientService.index().then((clients) {
      companyItems = clients
          .map((e) => SelectItem(id: e.id.toString(), name: e.name))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    // double width = MediaQuery.of(context).size.width;
    return Responsive(
      appBarTitle: 'Users List',
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: UserService.index(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                var users = snapShot.data as List<User>?;
                if (snapShot.hasData) {
                  return Column(
                    children: [
                      Text(
                        'Users List',
                        style: kPageHeaderTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 1000,
                        child: DataTable(
                            columns: [
                              'Username',
                              'Email',
                              'Client',
                              'Contact',
                              'Actions',
                            ].map((e) => DataColumn(label: Text(e))).toList(),
                            rows: users!
                                .map(
                                  (user) => DataRow(
                                    cells: [
                                      DataCell(Text(user.name)),
                                      DataCell(Text(user.email)),
                                      DataCell(Text(user.client!.name)),
                                      DataCell(Text(user.client!.contact)),
                                      DataCell(Row(
                                        children: [
                                          ElevatedButton(
                                            style: kElevatedButtonStyle(),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  scrollable: true,
                                                  title: Text('Edit User'),
                                                  content: userForm({
                                                    'id': user.id.toString(),
                                                    'username': user.name,
                                                    'email': user.email,
                                                    'clientId': user.client!.id
                                                  }),
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.edit),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            style: kElevatedButtonStyle(
                                                color: Colors.red),
                                            onPressed: () {},
                                            child: Icon(Icons.delete),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                )
                                .toList()),
                      )
                    ],
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget userForm([Map<String, dynamic>? data]) {
    if (data != null) {
      _emailController.text = data['email'];
      _usernameController.text = data['username'];
      _currentCompany = data['clientId'].toString();
    }
    return Container(
      constraints: BoxConstraints(minWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            kDivider(),
            TextFormField(
              controller: _usernameController,
              decoration: kInputDecoration('Enter Username'),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Username is required'
                    : null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              decoration: kInputDecoration('Enter email'),
              validator: (value) {
                bool valid = EmailValidator.validate(value!);

                return !valid ? 'Email is invalid' : null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value:
                  data != null ? data['clientId'].toString() : _currentCompany,
              decoration: kInputDecoration('Select Company'),
              items: companyItems
                  .map((item) => DropdownMenuItem(
                      value: '${item.id}', child: Text('${item.name}')))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _currentCompany = value!;
                });
              },
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Company is required'
                    : null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: kInputDecoration('Enter password'),
              validator: data != null
                  ? (value) {}
                  : (value) {
                      return value == null || value.isEmpty
                          ? 'Password is required'
                          : null;
                    },
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                  style: kElevatedButtonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });

                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var email = _emailController.text;
                      data == null
                          ? UserService.store(
                              username: username,
                              email: email,
                              password: password,
                              clientId: _currentCompany,
                            ).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              if (value) {
                                setState(() {
                                  _usernameController.text = '';
                                  _passwordController.text = '';
                                  _currentCompany = null;
                                });
                                kSuccessSnackBar(
                                    context, 'User added successfully');
                                kPopTrue(context);
                              } else {
                                kFailureSnackBar(context, 'Failed to add user');
                              }
                            })
                          : UserService.update(
                              id: data['id'],
                              username: username,
                              email: email,
                              password: password,
                              clientId: _currentCompany,
                            ).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              if (value) {
                                setState(() {
                                  _usernameController.text = '';
                                  _passwordController.text = '';
                                  _currentCompany = null;
                                });
                                kSuccessSnackBar(
                                    context, 'User updated successfully');
                                kPopTrue(context);
                              } else {
                                kFailureSnackBar(
                                    context, 'Failed to update user');
                              }
                            });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
