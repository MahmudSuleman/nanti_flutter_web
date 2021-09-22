import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/user.dart';

class UserService {
  static String baseUrl = kBaseUrl + 'users/';

  static Future<List<User>> allUsers() async {
    List<User> temp = [];
    try {
      var url = Uri.parse(baseUrl + 'index.php');
      var response = await http.get(url, headers: kHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;

        if (data != []) {
          data.forEach((element) {
            temp.add(User.fromJson(element));
          });
        }
      }
    } catch (error) {
      print(StackTrace.current);
    }

    return temp;
  }

  static Future<bool> store(username, company, password) async {
    var url = Uri.parse(baseUrl + 'store.php');
    var response = await http.post(url, body: {
      'username': username,
      'company_id': company,
      'password': password
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['success']) {
        return true;
      }
    }
    return false;
  }
}
