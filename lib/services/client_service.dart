import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client.dart';

class ClientService {
  static String baseUrl = kBaseUrl + 'client/';

  static Future<List<Client>> allClients() async {
    var url = Uri.parse(baseUrl + 'index.php');
    var response = await http.get(url);
    List<Client> temp = [];

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      for (var client in body) {
        temp.add(Client.fromJson(client));
      }
    }

    return temp;
  }

  static Future<http.Response> store(Client company) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: {
      'name': company.name,
      'client_type_id': company.typeId,
      'contact': company.contact
    });

    return response;
  }

  static Future<http.Response> update(Client client) async {
    var url = Uri.parse(baseUrl + '/update.php');
    var response = await http.post(url, body: {
      'id': client.id,
      'name': client.name,
      'client_type_id': client.typeId,
      'contact': client.contact,
    });

    return response;
  }

  static Future<bool> destroy(String id) async {
    var url = Uri.parse(baseUrl + '/destroy.php');
    var response = await http.post(url, body: {'id': id});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body['success'];
    }
    return false;
  }
}
