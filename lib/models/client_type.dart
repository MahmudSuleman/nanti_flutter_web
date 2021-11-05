class ClientType {
  final int id;
  final String name;

  ClientType({required this.id, required this.name});

  ClientType.fromJson(data)
      : id = data['id'],
        name = data['name'];
}
