import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/user_service.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class UserList extends StatefulWidget {
  static final String routeName = '/user-list';

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _formKey = GlobalKey<FormState>();
  List<SelectItem> companyItems = [];
  String? _currentCompany;

  //controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: MainContainer(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: UserService.allUsers(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  // late List<User>? data;
                  if (snapShot.hasData) {
                    // data = snapShot.data as List<User>;
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: ElevatedButton(
                              child: Text('Add User'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Add User'),
                                    content: _popUpForm(),
                                  ),
                                );

                                /// show add user popup
                              },
                            ),
                          ),
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
      ),
    );
  }

  void _saveData([username, company, password]) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserService.store(username, company, password).then((value) {
        if (value) {
          setState(() {
            _usernameController.text = '';
            _passwordController.text = '';
            _currentCompany = null;
          });
          Navigator.of(context).pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User added Successfully'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to add User'),
          ));
        }
      });
    }
  }

  Form _popUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: 'Enter Username'),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            value: _currentCompany,
            hint: Text('Select Company'),
            items: companyItems
                .map((item) => DropdownMenuItem(
                    value: '${item.id}', child: Text('${item.name}')))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                _currentCompany = value!;
              });
            },
            validator: (value) {},
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter password'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  //get the form data
                  var username = _usernameController.text;
                  var password = _passwordController.text;
                  _saveData(username, _currentCompany, password);
                }),
          )
        ],
      ),
    );
  }
}
