import 'dart:convert';

import 'package:nanti_flutter_web/models/user.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static void setUserPrefs(User user) async {
    var pref = await SharedPreferences.getInstance();
    var userData = jsonEncode({
      'id': user.id,
      'username': user.username,
      'companyId': user.companyId,
      'userTypeId': user.userType,
    });
    pref.setString('user', userData);
  }

  static Future<User?> getUserPrefs() async {
    var pref = await SharedPreferences.getInstance();
    var logged = await AuthService.isLoggedIn();
    if (logged) {
      var user = pref.getString('user');
      if (user != null) {
        print(jsonDecode(user));
        return User.fromJson(jsonDecode(user));
      }
    } else {
      return null;
    }
  }

  static Future<void> clearUser() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
  }
}
