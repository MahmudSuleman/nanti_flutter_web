import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/user_prefs.dart';

class DashboardSummaryService {
  static String baseUrl = kBaseUrl + 'dashboard_summary/';

  static Future<Map<String, dynamic>> adminDashboardSummary() async {
    late Map<String, dynamic> temp = {};
    try {
      var url = Uri.parse(baseUrl + 'admin_dashboard_summary.php');
      var response = await http.get(url, headers: kHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success']) {
          temp = data['data'];
        }
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    return temp;
  }

  static Future<Map<String, dynamic>> userDashboardSummary() async {
    late Map<String, dynamic> temp = {};
    try {
      var user = await UserPrefs.getUserPrefs();

      var url =
          Uri.parse(baseUrl + 'user_dashboard_summary.php?id=${user!.id}');
      var response = await http.get(url, headers: kHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success']) {
          temp = data['data'];
        }
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    return temp;
  }
}
