import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/common.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/user_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String baseUrl = kBaseUrl + 'auth/';

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
    isLoggedIn().then((value) {
      if (!value) {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      }
    });
  }

  static Future<bool> isLoggedIn() async {
    var pref = await SharedPreferences.getInstance();
    var user = pref.getString('user');
    if (user != null) {
      return true;
    }

    return false;
  }

  static Future<bool> isAdmin() async {
    var res = await isLoggedIn();
    if (res) {
      var user = await UserPrefs.getUserPrefs();
      if (user?.companyId == '0') {
        return true;
      }
    }
    return false;
  }
}
