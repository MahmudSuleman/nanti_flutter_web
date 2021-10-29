import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client.dart';

class ClientService extends ChangeNotifier {
  static String baseUrl = kBaseUrl2 + 'client';

  static Future<List<Client>> allClients() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    List<Client> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      for (Map<String, dynamic> client in body) {
        temp.add(Client.fromJson(client));
      }
    }
    return temp;
  }

  static Future<http.Response> store(Client client) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: {
      'name': client.name,
      'client_type_id': client.clientTypeId,
      'contact': client.contact
    });

    return response;
  }

  static Future<http.Response> update(Client client) async {
    var url = Uri.parse(baseUrl + '/update.php');
    var response = await http.post(url, body: {
      'id': client.id,
      'name': client.name,
      'client_type_id': client.clientTypeId,
      'contact': client.contact,
    });

    return response;
  }

  static Future<bool> destroy(int? id) async {
    var url = Uri.parse(baseUrl + '/destroy.php');
    var response = await http.post(url, body: {'id': id});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body['success'];
    }
    return false;
  }
}
