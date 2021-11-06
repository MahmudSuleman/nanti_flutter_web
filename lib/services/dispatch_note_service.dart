import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';

class DispatchNoteService {
  static String baseUrl = kBaseUrl2 + '/dispatch-note';

  static Future<List<DispatchNote>> index() async {
    var url = Uri.parse(baseUrl);

    var response = await http.get(url);
    List<DispatchNote> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      body.forEach((element) {
        temp.add(DispatchNote.fromJson(element));
      });
    }
    return temp;
  }

  static Future<bool> store(DispatchNote note) async {
    var url = Uri.parse(baseUrl);
    var response = await http.post(url, body: {
      'note': note.note,
      'note_date': note.noteDate,
      'client_id': note.clientId.toString()
    });
    return response.statusCode == 201;
  }

  static Future<bool> update(DispatchNote note) async {
    var url = Uri.parse('$baseUrl/${note.id}');
    var response = await http.put(url, body: {
      'note': note.note,
      'noteDate': note.noteDate,
      'clientId': note.clientId.toString()
    });
    return response.statusCode == 200;
  }

  static Future<bool> destroy(id) async {
    var url = Uri.parse('$baseUrl/$id');
    var response = await http.delete(url);
    return response.statusCode == 204;
  }
}
