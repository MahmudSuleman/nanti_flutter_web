import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/user_prefs.dart';

class DashboardSummaryService {
  static String baseUrl = kBaseUrl + '/dashboard-summary';

  static Future<Map<String, dynamic>> adminDashboardSummary() async {
    late Map<String, dynamic> temp = {};
    try {
      var url = Uri.parse(baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        temp = data;
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

// TODO: Change this to get the user id from the user prefs
      var url = Uri.parse(baseUrl + 'user_dashboard_summary.php?id=1');
      var response = await http.get(url, headers: kHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success']) {
          temp = data['data'];
        }
      }
    } catch (e) {
      print(e);
    }

    return temp;
  }
}
