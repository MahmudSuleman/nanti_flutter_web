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
      backgroundColor: Color.fromRGBO(200, 200, 200, 1),
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: kAppBarBackground,
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
                      _form(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Form _form() => Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          children: [
            TextFormField(
              decoration: kInputDecoration('Username'),
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
              decoration: kInputDecoration('Password'),
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
            _submitButton(),
          ],
        ),
      ));

  MaterialButton _submitButton() => MaterialButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        minWidth: double.infinity,
        color: kAppBarBackground,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            setState(() {
              isLoading = true;
            });
            var username = _usernameController.text;
            var password = _passwordController.text;

            AuthService.login(username, password).then((value) {
              setState(() {
                isLoading = false;
              });
              if (value.statusCode == 200) {
                var body = jsonDecode(value.body) as Map<String, dynamic>;
                if (body['success']) {
                  UserPrefs.setUserPrefs(User.fromJson(body['data']));

                  Navigator.pushReplacementNamed(context, '/');
                } else {
                  // setState(() {
                  //   isLoading = false;
                  // });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to login, please try again.')));
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to login, please try again.')));
              }
            }).catchError((error) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to login, please try again.')));
            });
          }
        },
      );
}
