class Dispatch {
  String id;
  String deviceName;
  String companyName;
  String? isAvailable;

  Dispatch({
    required this.id,
    required this.deviceName,
    required this.companyName,
    this.isAvailable,
  });

  Dispatch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceName = json['deviceName'],
        companyName = json['companyName'],
        isAvailable = json['isAvailable'];
}
