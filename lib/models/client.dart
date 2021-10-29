// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact": contact,
        "client_type_id": clientTypeId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "client_type": clientType!.toJson(),
      };
}

class ClientType {
  ClientType({
    this.id,
    required this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ClientType.fromJson(Map<String, dynamic> json) {
    return ClientType(
      id: json["id"],
      name: json["name"],
      deletedAt: json["deleted_at"] != null
          ? DateTime.parse(json["deleted_at"])
          : null,
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
