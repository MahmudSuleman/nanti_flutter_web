class Client {
  final String id;
  final String name;
  final String typeId;
  String? typeName;
  final String contact;

  Client({
    required this.id,
    required this.name,
    required this.typeId,
    required this.contact,
  });

  Client.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['client_name'],
        typeId = json['client_type_id'],
        typeName = json['client_type_name'],
        contact = json['contact'];
}
