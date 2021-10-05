import 'package:nanti_flutter_web/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/models/company.dart';

class ClientService {
  static String baseUrl = kBaseUrl + 'company/';

  static Future<List<Client>> allClients() async {
    var url = Uri.parse(baseUrl + 'index.php');
    var response = await http.get(url, headers: kHeaders);
    List<Client> temp = [];

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      for (var company in body) {
        temp.add(Client.fromJson(company));
      }
    }
    return temp;
  }

  static Future<http.Response> store(Client company) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: {
      'name': company.name,
      'type': company.type,
      'contact': company.contact
    });

    return response;
  }

  static Future<http.Response> update(Client company) async {
    var url = Uri.parse(baseUrl + '/update.php');
    var response = await http.post(url, body: {
      'id': company.id,
      'name': company.name,
      'type': company.type,
      'contact': company.contact,
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
