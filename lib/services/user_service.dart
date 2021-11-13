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

  static Future<bool> store({username, email, clientId, password}) async {
    try {
      var url = Uri.parse(baseUrl);
      var response = await http.post(url, body: {
        'name': username,
        'client_id': clientId,
        'password': password,
        'email': email,
      });
      return response.statusCode == 200;
    } catch (error) {
      print(StackTrace.current);
      return false;
    }
  }

  static Future<bool> update({username, email, clientId, password}) async {
    try {
      var url = Uri.parse(baseUrl);
      var response = await http.put(url, body: {
        'name': username,
        'client_id': clientId,
        'password': password,
        'email': email,
      });
      return response.statusCode == 200;
    } catch (error) {
      print(StackTrace.current);
      return false;
    }
  }
}
