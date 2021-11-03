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
    this.createdAt,
    this.updatedAt,
    this.manufacturer,
  });

  int? id;
  String name;
  String model;
  String serialNumber;
  int? isAvailable;
  int manufacturerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Manufacturer? manufacturer;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        name: json["name"],
        model: json["model"],
        serialNumber: json["serial_number"],
        isAvailable: json["is_available"],
        manufacturerId: json["manufacturer_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        manufacturer: Manufacturer.fromJson(json["manufacturer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "model": model,
        "serial_number": serialNumber,
        "is_available": isAvailable,
        "manufacturer_id": manufacturerId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "manufacturer": manufacturer!.toJson(),
      };
}
