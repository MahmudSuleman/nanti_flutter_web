import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

import '../common.dart';
import '../user_prefs.dart';

class MaintenanceService {
  static String baseUrl = kBaseUrl + '/maintenances/';

  static Future<List<Maintenance>> allMaintenance() async {
    var url = Uri.parse(baseUrl + 'index.php');
    List<Maintenance> temp = [];
    try {
      var response = await http.get(url, headers: kHeaders);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        for (var maintenance in body) {
          temp.add(Maintenance.fromJson(maintenance));
        }
      }
    } catch (e) {
      print('exception in maintenance service; all maintenance' + e.toString());
    }
    return temp;
  }

  static Future<List<Maintenance>> allUserMaintenance() async {
    var url = Uri.parse(baseUrl + 'index.php');
    List<Maintenance> temp = [];
    try {
      var response = await http.get(url, headers: kHeaders);
      var isAdmin = await AuthService.isAdmin();
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        if (!isAdmin) {
          var pref = await UserPrefs.getUserPrefs();
          if (pref != null) {
            for (var maintenance in body) {
              if (pref.companyId == maintenance['companyId'])
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

  static Future<Map<String, dynamic>> store(
      companyId, deviceId, problemDescription) async {
    late Map<String, dynamic> temp;
    try {
      var url = Uri.parse(baseUrl + 'store.php');
      var response = await http.post(url, body: {
        'companyId': companyId,
        'deviceId': deviceId,
        'problemDescription': problemDescription
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body['success']) {
          temp = body;
        } else {
          temp = body;
        }
      } else {
        print('error: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
    }

    return temp;
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

        print('server error, error: ${response.body}');
      }
    } catch (e) {
      isDone = false;

      print(StackTrace.current);
    }
    return isDone;
  }
}
