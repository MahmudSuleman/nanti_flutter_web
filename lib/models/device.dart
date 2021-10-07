class Device {
  final String id;
  final String serialNumber;
  final String manufacturerId;
  final String name;
  final String model;
  final String? isAvailable;
  String? manufacturerName;

  Device({
    required this.id,
    required this.manufacturerId,
    required this.name,
    required this.serialNumber,
    required this.model,
    this.isAvailable,
  });

  Device.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        serialNumber = json['serial_number'],
        name = json['name'],
        manufacturerId = json['manufacturer_id'],
        manufacturerName = json['manufacturer_name'],
        model = json['model'],
        isAvailable = json['is_available'];

  @override
  String toString() {
    return 'id: $id, serialNumber: $serialNumber, \nname: $name, manufacturer: $manufacturerId, model: $model, isAvailable: $isAvailable';
  }
}
