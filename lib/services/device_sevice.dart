import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/models/device.dart';

class DeviceService {
  static String baseUrl =
      'http://10.0.2.2/nanti_flutter_web_api/endpoint/devices';
  // var baseUrl = 'https://www.google.com';

  static Future<List<Device>> allDevices() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    List<Device> temp = [];
    if (response.statusCode == 200) {
      // print('body: ${response.body}');
      List<dynamic> body = jsonDecode(response.body);
      for (Map<String, dynamic> device in body) {
        print(device);
        temp.add(Device.fromJson(device));
      }
    }
    return temp;
  }

  static Future<http.Response> store(Device device) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: {
      'name': device.name,
      'manufacturer': device.manufactuer,
      'serialNumber': device.serialNumber,
    });

    return response;
  }

  static Future<http.Response> update(Device device) async {
    var url = Uri.parse(baseUrl + '/update.php');
    var response = await http.post(url, body: {
      'id': device.id,
      'name': device.name,
      'manufacturer': device.manufactuer,
      'serialNumber': device.serialNumber,
    });

    return response;
  }
}
