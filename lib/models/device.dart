class Device {
  final String id;
  final String serialNumber;
  final String manufacturerId;
  final String name;
  final String model;
  final String? isAvailable;
  String? manufacturer;

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
        serialNumber = json['serialNumber'],
        name = json['name'],
        manufacturerId = json['manufacturer_id'],
        manufacturer = json['manufacturer'],
        model = json['model'],
        isAvailable = json['isAvailable'];

  @override
  String toString() {
    return 'id: $id, serialNumber: $serialNumber, \nname: $name, manufacturer: $manufacturerId, model: $model, isAvailable: $isAvailable';
  }
}
