import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/main.dart';
import 'package:nanti_flutter_web/models/user.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/user_prefs.dart';

class Login extends StatelessWidget {
  static String routeName = '/login';
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Please Login',
                  style: kPageHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Enter username'),
                          controller: _usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide username';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Enter password'),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide password';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          child: Text('Submit'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              var username = _usernameController.text;
                              var password = _passwordController.text;

                              AuthService.login(username, password)
                                  .then((value) {
                                if (value.statusCode == 200) {
                                  var body = jsonDecode(value.body)
                                      as Map<String, dynamic>;
                                  print('body: ${value.body}');
                                  if (body['success']) {
                                    UserPrefs.setUserPrefs(
                                        User.fromJson(body['data']));

                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to login, prlease try again.')));
                                  }
                                }
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Failed to login, prlease tyr again.')));
                                print('error: $error');
                              });
                            }
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
