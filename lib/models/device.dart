class Device {
  final String id;
  final String serialNumber;
  final String manufactuer;
  final String name;
  final String model;
  final String? isAvailable;

  Device({
    required this.id,
    required this.manufactuer,
    required this.name,
    required this.serialNumber,
    required this.model,
    this.isAvailable,
  });

  Device.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        serialNumber = json['serialNumber'],
        name = json['name'],
        manufactuer = json['manufacturer'],
        model = json['model'],
        isAvailable = json['isAvailable'];
}
