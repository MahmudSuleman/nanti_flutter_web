class Client {
  final String id;
  final String name;
  final String type;
  final String contact;

  Client({
    required this.id,
    required this.name,
    required this.type,
    required this.contact,
  });

  Client.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        contact = json['contact'];
}
