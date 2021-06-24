import 'dart:convert';

import 'package:nanti_flutter_web/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static void setUserPrefs(User user) async {
    var pref = await SharedPreferences.getInstance();
    var userData = jsonEncode({
      'id': user.id,
      'username': user.username,
      'companyId': user.companyId,
      'userType': user.userType,
    });
    pref.setString('user', userData);
  }

  static Future<User?> getUserPrefs() async {
    var pref = await SharedPreferences.getInstance();
    var logged = await isLoggedIn();
    if (logged) {
      Map<String, dynamic> user =
          pref.getString('user') as Map<String, dynamic>;
      return User.fromJson(user);
    } else {
      return null;
    }
  }

  static Future<void> clearUser() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
  }

  static Future<bool> isLoggedIn() async {
    var pref = await SharedPreferences.getInstance();
    var user = pref.getString('user');
    if (user != null) {
      return true;
    }

    return false;
  }
}
