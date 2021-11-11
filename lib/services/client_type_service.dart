import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client_type.dart';

class ClientTypeService {
  static String baseUrl = kBaseUrl + '/client-type';

  static Future<List<ClientType>> allClientTypes() async {
    var url = Uri.parse(baseUrl);
    List<ClientType> clientTypes = [];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      body.forEach((element) {
        clientTypes.add(ClientType.fromJson(element));
      });
    }
    return clientTypes;
  }
}
