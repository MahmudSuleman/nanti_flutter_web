class Maintenance {
  String id;
  String dateSent;
  String companyName;
  String deviceName;
  String problemDescription;

  Maintenance(
      {required this.id,
      required this.deviceName,
      required this.companyName,
      required this.dateSent,
      required this.problemDescription});

  Maintenance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceName = json['deviceName'],
        companyName = json['companyName'],
        dateSent = json['dateSent'],
        problemDescription = json['problemDescription'];
}
