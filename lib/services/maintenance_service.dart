import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

import '../common.dart';
import '../user_prefs.dart';

class MaintenanceService {
  static String baseUrl = kBaseUrl + '/maintenance';

  static Future<List<Maintenance>> allMaintenance() async {
    var url = Uri.parse(baseUrl + 'index.php');
    List<Maintenance> temp = [];
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        for (var maintenance in body) {
          temp.add(Maintenance.fromJson(maintenance));
        }
      }
    } catch (e) {
      print(StackTrace.current);
    }
    return temp;
  }

  static Future<List<Maintenance>> allUserMaintenance() async {
    var url = Uri.parse(baseUrl + 'index.php');
    List<Maintenance> temp = [];
    try {
      var response = await http.get(url);
      var isAdmin = await AuthService.isAdmin();
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        if (!isAdmin) {
          var pref = await UserPrefs.getUserPrefs();
          if (pref != null) {
            for (var maintenance in body) {
              // TODO: fix company id filtering
              // if (pref.companyId == maintenance['companyId'])
              temp.add(Maintenance.fromJson(maintenance));
            }
          }
        }
      }
    } catch (e) {
      print(Common.exceptionMessage('maintenance service', e.toString()));
    }
    return temp;
  }

  static Future<bool> store(companyId, deviceId, problemDescription) async {
    var url = Uri.parse(baseUrl);

    var bodyData = {
      'client_id': companyId.toString(),
      'device_id': deviceId.toString(),
      'problem': problemDescription
    };
    return http.post(url, body: bodyData).then((value) {
      return value.statusCode == 200;
    }).catchError((onError) {
      // print(onError);
      return false;
    });
  }

  static Future<bool> markAsDone(maintenanceId) async {
    late bool isDone;
    try {
      var url = Uri.parse(baseUrl + '/mark_done.php');
      var response = await http.post(url, body: {'id': maintenanceId});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          isDone = true;
        } else {
          isDone = false;
        }
      } else {
        isDone = false;
        print(StackTrace.current);
      }
    } catch (e) {
      isDone = false;
      print(StackTrace.current);
    }
    return isDone;
  }
}
