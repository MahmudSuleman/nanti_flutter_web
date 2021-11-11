import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/user_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String baseUrl = kBaseUrl;

  static Future<http.Response> login(username, password) async {
    var url = Uri.parse(baseUrl + '/login');
    var response = await http.post(url, body: {
      'name': username,
      'password': password,
    });
    return response;
  }

  static Future<void> autoLogout(context) async {
    isLoggedIn().then((value) {
      if (!value) {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => Login()),
          ModalRoute.withName('/login'),
        );
      }
    });
  }

  static Future<bool> isLoggedIn() async {
    var pref = await SharedPreferences.getInstance();
    var user = pref.getString('user');
    return user != null;
  }

  static Future<bool> isAdmin() async {
    var res = await isLoggedIn();
    if (res) {
      var user = await UserPrefs.getUserPrefs();
      if (user != null) {
        return user['company'] == '0';
      }
    }
    return false;
  }
}
