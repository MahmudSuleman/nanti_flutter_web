class Device {
  final String id;
  final String serialNumber;
  final String manufactuer;
  final String name;

  Device({
    required this.id,
    required this.manufactuer,
    required this.name,
    required this.serialNumber,
  });

  Device.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serialNumber = json['serialNumber'],
        name = json['name'],
        manufactuer = json['manufacturer'];
}
