// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/models/client_type.dart';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

class Client extends ChangeNotifier {
  Client({
    this.id,
    required this.name,
    required this.contact,
    required this.clientTypeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clientType,
  });

  int? id;
  String name;
  String contact;
  int clientTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  ClientType? clientType;

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json["id"],
      name: json["name"],
      contact: json["contact"],
      clientTypeId: json["client_type_id"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json["deleted_at"] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      clientType: ClientType.fromJson(json["client_type"]),
    );
  }
}
