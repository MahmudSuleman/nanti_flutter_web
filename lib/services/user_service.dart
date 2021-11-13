import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/user.dart';

class UserService {
  static String baseUrl = kBaseUrl + '/user';

  static Future<List<User>?> index() async {
    try {
      List<User> temp = [];
      var url = Uri.parse(baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;
        data.forEach((element) {
          temp.add(User.fromJson(element));
        });
        return temp;
      } else {
        return null;
      }
    } catch (error) {
      print(StackTrace.current);
    }

    return null;
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
