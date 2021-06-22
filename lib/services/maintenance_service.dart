import 'dart:convert';

import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/maintenance.dart';
import 'package:http/http.dart' as http;

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
}
