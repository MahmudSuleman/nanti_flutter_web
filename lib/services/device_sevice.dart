import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';

class DeviceService {
  static String baseUrl = kBaseUrl + '/devices';

  static Future<List<Device>> allDevices() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    List<Device> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      for (Map<String, dynamic> device in body) {
        temp.add(Device.fromJson(device));
      }
    }
    return temp;
  }

  static Future<bool> destroy(String id) async {
    var url = Uri.parse(baseUrl + '/destroy.php?id=' + id);
    var response = await http
        .get(url, headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body['success'];
    }
    return false;
  }

  static Future<Device?> find(String id) async {
    var url = Uri.parse(baseUrl + '/single.php?id=' + id);
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    Device? device;
    if (response.statusCode == 200) {
      List<Map<String, String>> body = jsonDecode(response.body);
      device = Device.fromJson(body[0]);
    }

    return device;
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
