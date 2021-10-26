class DispatchNote {
  final String? id;
  final String note;
  final String noteDate;
  final String clientId;
  String? clientName;
  String? deletedAt;

  DispatchNote({
    this.id,
    required this.note,
    required this.noteDate,
    required this.clientId,
  });

  DispatchNote.fromJson(json)
      : id = json['id'],
        note = json['note'],
        noteDate = json['note_date'],
        clientId = json['client_id'],
        clientName = json['client_name'],
        deletedAt = json['deleted_at'];
}
