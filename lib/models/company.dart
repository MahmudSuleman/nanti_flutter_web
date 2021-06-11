class Company {
  final String id;
  final String name;
  final String type;
  final String contact;

  Company({
    required this.id,
    required this.name,
    required this.type,
    required this.contact,
  });

  Company.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        contact = json['contact'];
}
