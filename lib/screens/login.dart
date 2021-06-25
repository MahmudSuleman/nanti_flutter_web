import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/user.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/user_prefs.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                                decoration: InputDecoration(
                                    labelText: 'Enter username'),
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
                                decoration: InputDecoration(
                                    labelText: 'Enter password'),
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
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var username = _usernameController.text;
                                    var password = _passwordController.text;
                                    print('username: $username');

                                    AuthService.login(username, password)
                                        .then((value) {
                                      print('response ${value.body}');
                                      setState(() {
                                        isLoading = false;
                                      });
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
                                          // setState(() {
                                          //   isLoading = false;
                                          // });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Failed to login, please try again.')));
                                        }
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Failed to login, please try again.')));
                                      }
                                    }).catchError((error) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Failed to login, prlease tyr again.')));
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
