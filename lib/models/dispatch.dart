class Dispatch {
  String id;
  String deviceId;
  String? deviceName;
  String clientId;
  String? clientName;
  String dispatchDate;
  String? isAvailable;

  Dispatch({
    required this.id,
    required this.deviceId,
    required this.clientId,
    required this.dispatchDate,
    this.isAvailable,
  });

  Dispatch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceId = json['device_id'],
        deviceName = json['device_name'],
        clientId = json['client_id'],
        clientName = json['client_name'],
        dispatchDate = json['dispatch_date'],
        isAvailable = json['isAvailable'];
}
