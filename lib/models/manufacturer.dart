class Manufacturer {
  final String id;
  final String name;

  Manufacturer({required this.id, required this.name});

  Manufacturer.fromJson(data)
      : this.id = data['id'],
        this.name = data['name'];
}
