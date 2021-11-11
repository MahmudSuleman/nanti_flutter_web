class Manufacturer {
  Manufacturer({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
