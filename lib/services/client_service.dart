import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client.dart';

class ClientService extends ChangeNotifier {
  static String baseUrl = kBaseUrl + '/client';

  static Future<List<Client>> index() async {
    var url = Uri.parse(baseUrl);
    late List<Client> temp = [];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      for (Map<String, dynamic> client in body) {
        temp.add(Client.fromJson(client));
      }
    }
    return temp;
  }

  static Future<http.Response> store(Client client) async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(url, body: {
      'name': client.name,
      'client_type_id': client.clientTypeId.toString(),
      'contact': client.contact
    });

    return response;
  }

  static Future<http.Response> update(Client client) async {
    var url = Uri.parse(baseUrl + '/${client.id}');
    var response = await http.put(url, body: {
      'name': client.name,
      'client_type_id': client.clientTypeId.toString(),
      'contact': client.contact,
    });

    return response;
  }

  static Future<bool> destroy(int? id) async {
    var url = Uri.parse(baseUrl + '/$id');
    var response = await http.delete(url, body: {'id': id.toString()});
    return response.statusCode == 204;
  }
}
