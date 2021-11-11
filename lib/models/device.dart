import 'dart:convert';

import 'manufacturer.dart';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    this.id,
    required this.name,
    required this.model,
    required this.serialNumber,
    this.isAvailable,
    required this.manufacturerId,
    this.manufacturer,
  });

  int? id;
  String name;
  String model;
  String serialNumber;
  int? isAvailable;
  int manufacturerId;
  Manufacturer? manufacturer;

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json["id"],
      name: json["name"],
      model: json["model"],
      serialNumber: json["serial_number"],
      isAvailable: int.parse(json["is_available"]),
      manufacturerId: int.parse(json["manufacturer_id"]),
      manufacturer: json["manufacturer"] == null
          ? null
          : Manufacturer.fromJson(json["manufacturer"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "model": model,
        "serial_number": serialNumber,
        "is_available": isAvailable,
        "manufacturer_id": manufacturerId,
        "manufacturer": manufacturer!.toJson(),
      };
}
