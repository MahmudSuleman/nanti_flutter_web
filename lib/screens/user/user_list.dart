import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/models/user.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/user_service.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';

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
    return Responsive(
      appBarTitle: 'User List',
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: AddItemButton(onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Add User'),
                              content: userForm(),
                            ),
                          );

                          /// show add user popup
                        }),
                      ),
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
                            ].map((e) => DataColumn(label: Text(e))).toList(),
                            rows: users!
                                .map(
                                  (user) => DataRow(
                                    cells: [
                                      DataCell(Text(user.name)),
                                      DataCell(Text(user.email)),
                                      DataCell(Text(user.client!.name)),
                                      DataCell(Text(user.client!.contact)),
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

  void _saveData([username, email, clientId, password]) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      UserService.store(
        username: username,
        email: email,
        password: password,
        clientId: clientId,
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
          kSuccessSnackBar(context, 'User added successfully');
          kPopTrue(context);
        } else {
          kFailureSnackBar(context, 'Failed to add user');
        }
      });
    }
  }

  Form userForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            value: _currentCompany,
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
            validator: (value) {
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
                  //get the form data

                  var username = _usernameController.text;
                  var password = _passwordController.text;
                  var email = _emailController.text;
                  _saveData(username, email, _currentCompany, password);
                }),
          )
        ],
      ),
    );
  }
}
