import 'dart:io';

import 'package:http/http.dart' as http;

class DeviceService {
  var baseUrl =
      'https://ac328468a4ab.ngrok.io/nanti_flutter_web_api/endpoint/devices/index.php';
  // var baseUrl = 'https://www.google.com';

  Future<void> allDevices() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
