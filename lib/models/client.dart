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
    this.clientType,
  });

  int? id;
  String name;
  String contact;
  int clientTypeId;
  ClientType? clientType;

  factory Client.fromJson(json) {
    return Client(
      id: json["id"] ?? null,
      name: json["name"] ?? "",
      contact: json["contact"] ?? "",
      clientTypeId: json["client_type_id"] ?? 0,
      clientType: json["client_type"] != null
          ? ClientType.fromJson(json["client_type"])
          : null,
    );
  }
}
