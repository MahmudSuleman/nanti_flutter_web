import 'dart:convert';

import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static void setUserPrefs(Map<String, dynamic> data) async {
    var pref = await SharedPreferences.getInstance();
    var userData = jsonEncode({
      'token': data['token'],
      'company': data['company'],
    });
    pref.setString('user', userData);
  }

  static Future<Map<String, dynamic>?> getUserPrefs() async {
    var pref = await SharedPreferences.getInstance();
    var logged = await AuthService.isLoggedIn();
    if (logged) {
      var user = pref.getString('user');
      if (user != null) {
        return jsonDecode(user);
      }
    }
    return null;
  }

  static Future<void> clearUser() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
  }
}
