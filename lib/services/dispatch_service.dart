import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';

import '../user_prefs.dart';
import 'auth_service.dart';

class DispatchService {
  static String baseUrl = kBaseUrl + 'dispatches';

  static Future<List<Dispatch>> allDispatches() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    List<Dispatch> temp = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (Map<String, dynamic> dispatch in body) {
        temp.add(Dispatch.fromJson(dispatch));
      }
    }

    return temp;
  }

  static Future<List<Map<String, dynamic>>> userDispatches() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    List<Map<String, dynamic>> temp = [];
    var isAdmin = await AuthService.isAdmin();

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (!isAdmin) {
        var pref = await UserPrefs.getUserPrefs();
        if (pref != null) {
          for (Map<String, dynamic> dispatch in body) {
            if (pref.companyId == dispatch['companyId']) temp.add(dispatch);
          }
        }
      }
    }

    return temp;
  }

  static Future<http.Response> store(Map<String, String> dispatch) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: dispatch);
    return response;
  }

  static Future<List<Device>> available() async {
    var url = Uri.parse(baseUrl + '/available.php');

    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    List<Device> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      for (Map<String, dynamic> device in body) {
        temp.add(Device.fromJson(device));
      }
    }

    return temp;
  }
}
