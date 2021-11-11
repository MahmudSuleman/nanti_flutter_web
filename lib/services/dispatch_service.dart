import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';

import '../user_prefs.dart';
import 'auth_service.dart';

class DispatchService {
  static String baseUrl = kBaseUrl + '/dispatch';

  static Future<List<Dispatch>> allDispatches() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    List<Dispatch> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      body.forEach((element) {
        Dispatch dispatch = Dispatch.fromJson(element);
        if (dispatch.device!.isAvailable == 0 && dispatch.deletedAt == null) {
          temp.add(Dispatch.fromJson(element));
        }
      });
    }

    return temp;
  }

  static Future<List<Map<String, dynamic>>> userDispatches() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(url);
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

  static Future<bool> store(Dispatch dispatch) async {
    var url = Uri.parse(baseUrl);

    var response = await http.post(url, body: {
      'client_id': dispatch.clientId.toString(),
      'device_id': dispatch.deviceId.toString(),
      'note': dispatch.note,
      'date': dispatch.date,
    });

    return response.statusCode == 201;
  }

  static Future<List<Device>> available() async {
    List<Device> devices = await DeviceService.allDevices();
    List<Device> temp = [];

    devices.forEach((element) {
      if (element.isAvailable == 1) temp.add(element);
    });
    return temp;
  }

  static Future<bool> retrieve(id) async {
    var url = Uri.parse(baseUrl + '/retrieve/$id');
    var response = await http.post(url);
    print(response.body);
    return response.statusCode == 200;
  }
}
