import 'client.dart';
import 'device.dart';

class Dispatch {
  int? id;
  int deviceId;
  int clientId;
  String date;
  String note;
  Client? client;
  Device? device;
  DateTime? deletedAt;

  Dispatch(
      {this.id,
      required this.deviceId,
      required this.clientId,
      required this.note,
      required this.date,
      this.client,
      this.deletedAt,
      this.device});

  factory Dispatch.fromJson(Map<String, dynamic> json) {
    return Dispatch(
      id: json['id'],
      deviceId: json['device_id'].runtimeType == int
          ? json['device_id']
          : int.parse(json['device_id']),
      clientId: json['client_id'].runtimeType == int
          ? json['client_id']
          : int.parse(json['client_id']),
      date: json['date'],
      note: json['note'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
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
