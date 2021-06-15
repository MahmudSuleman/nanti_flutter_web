import 'dart:convert';
import 'dart:io';

import 'package:nanti_flutter_web/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/models/dispatch.dart';

class DispatchService {
  static String baseUrl = kBaseUrl + '/dispatches';

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
}
