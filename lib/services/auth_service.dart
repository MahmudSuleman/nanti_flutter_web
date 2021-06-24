import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/common.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/screens/login.dart';

import '../user_prefs.dart';

class AuthService {
  static String baseUrl = kBaseUrl + '/auth/';

  static Future<http.Response> login(username, password) async {
    late var response;
    try {
      var url = Uri.parse(baseUrl + 'login.php');
      response = await http
          .post(url, body: {'username': username, 'password': password});
    } catch (e) {
      print(Common.exceptionMessage('AuthService Login', e.toString()));
    }
    return response;
  }

  static Future<void> autoLogout(context) async {
    UserPrefs.isLoggedIn().then((value) {
      if (!value) {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      }
    });
  }
}
