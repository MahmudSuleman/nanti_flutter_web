class ClientType {
  final String id;
  final String name;
  String? createdAt;
  String? deletedAt;

  ClientType({required this.id, required this.name});

  ClientType.fromJson(data)
      : id = data['id'],
        name = data['name'],
        createdAt = data['created_at'],
        deletedAt = data['deleted_at'];
}
