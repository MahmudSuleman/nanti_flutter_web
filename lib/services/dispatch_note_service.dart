import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';

class DispatchNoteService {
  static String baseUrl = kBaseUrl + 'dispatch_note';

  static Future<List<DispatchNote>> allNote() async {
    var url = Uri.parse(baseUrl + '/index.php');
    var response = await http.get(url, headers: kHeaders);
    List<DispatchNote> temp = [];
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      body.forEach((element) {
        temp.add(DispatchNote.fromJson(element));
      });
    }
    return temp;
  }

  static Future<bool> addNote(DispatchNote note) async {
    var url = Uri.parse(baseUrl + '/store.php');
    var response = await http.post(url, body: {
      'note': note.note,
      'noteDate': note.noteDate,
      'clientId': note.clientId
    });
    return response.statusCode == 200;
  }

  static Future<bool> editNote(DispatchNote note) async {
    var url = Uri.parse(baseUrl + '/update.php');
    var response = await http.post(url, body: {
      'id': note.id,
      'note': note.note,
      'noteDate': note.noteDate,
      'clientId': note.clientId
    });
    print(note);
    return response.statusCode == 200;
  }
}
