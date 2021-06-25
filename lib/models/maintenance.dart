class Maintenance {
  String id;
  String dateSent;
  String companyName;
  String deviceName;
  String problemDescription;
  String? companyId;

  Maintenance({
    required this.id,
    required this.deviceName,
    required this.companyName,
    required this.dateSent,
    required this.problemDescription,
    this.companyId,
  });

  Maintenance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceName = json['deviceName'],
        companyName = json['companyName'],
        dateSent = json['dateSent'],
        companyId = json['companyId'],
        problemDescription = json['problemDescription'];
}
