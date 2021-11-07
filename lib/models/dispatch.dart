import 'client.dart';
import 'device.dart';

class Dispatch {
  int? id;
  int deviceId;
  int clientId;
  String? date;
  String? note;
  Client? client;
  Device? device;

  Dispatch(
      {this.id,
      required this.deviceId,
      required this.clientId,
      required this.note,
      this.date,
      this.client,
      this.device});

  factory Dispatch.fromJson(Map<String, dynamic> json) {
    return Dispatch(
      id: json['id'],
      deviceId: json['device_id'],
      clientId: json['client_id'],
      date: json['date'],
      note: json['note'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      device: json['device'] != null ? Device.fromJson(json['device']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'device_id': deviceId,
        'client_id': clientId,
        'date': date,
        'note': note,
      };
}
