import 'dart:io';

import 'package:nanti_flutter_web/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/models/company.dart';

class CompanyService {
  static String baseUrl = kBaseUrl + 'company/';

  static Future<List<Company>> allCompanies() async {
    var url = Uri.parse(baseUrl + 'index.php');
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    List<Company> temp = [];

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      for (var company in body) {
        temp.add(Company.fromJson(company));
      }
    }
    return temp;
  }
}
