import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/device.dart';

class DeviceService {
  static String baseUrl = kBaseUrl2 + '/device';

  static Future<List<Device>> allDevices() async {
    List<Device> temp = [];
    var url = Uri.parse(baseUrl);
    var response = await http.get(url, headers: kHeaders);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      for (Map<String, dynamic> device in body) {
        temp.add(Device.fromJson(device));
      }
    }

    return temp;
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
      'manufacturer': device.manufacturerId,
      'model': device.model,
      'serialNumber': device.serialNumber,
    });

    return response;
  }

  static Future<http.Response> update(Device device) async {
    var url = Uri.parse(baseUrl + '/update.php');
    final body = {
      'id': device.id,
      'name': device.name,
      'manufacturerId': device.manufacturerId,
      'model': device.model,
      'serialNumber': device.serialNumber,
    };

    var response = await http.post(url, body: body);
    return response;
  }
}
