import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/services/dispatch_note_service.dart';

class DispatchNoteProvider extends ChangeNotifier {
  List<DispatchNote> _notes = [];

  void init() {
    DispatchNoteService.allNote().then((value) => _notes = value);
  }

  List<DispatchNote> get allNotes {
    return [..._notes];
  }
}
