import 'package:nanti_flutter_web/models/client.dart';

class User {
  int id;
  String name;
  String email;
  int clientId;
  Client? client;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.clientId,
    this.client,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        clientId = json['client_id'].runtimeType == int
            ? json['client_id']
            : int.parse(json['client_id']),
        client =
            json['client'] == null ? null : Client.fromJson(json['client']);
}
