import 'client.dart';

class DispatchNote {
  final int? id;
  final String note;
  final String noteDate;
  final int clientId;
  final Client? client;

  DispatchNote(
      {this.id,
      required this.note,
      required this.noteDate,
      required this.clientId,
      this.client});

  factory DispatchNote.fromJson(json) {
    DispatchNote note = DispatchNote(
      id: json['id'],
      note: json['note'],
      noteDate: json['note_date'],
      clientId: json['client_id'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
    );

    print('note id: $note.id');
    return note;
  }
}
