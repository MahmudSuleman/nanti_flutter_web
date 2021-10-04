import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/manufacturer.dart';

class ManufacturerService {
  static String baseUrl = '$kBaseUrl/manufacturer';

  static Future<List<Manufacturer>> allManufacturers() async {
    final url = Uri.parse('$baseUrl/index.php');

    List<Manufacturer> manufacturer = [];
    try {
      var response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        body.forEach((element) {
          manufacturer.add(Manufacturer.fromJson(element));
        });
      }
    } catch (error) {
      print(StackTrace.current);
    }
    return manufacturer;
  }
}
