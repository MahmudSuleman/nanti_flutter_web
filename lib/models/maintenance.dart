class Maintenance {
  String id;
  String dateSent;
  String companyName;
  String deviceName;
  String problemDescription;
  String? companyId;
  String? dateDone;
  String isDone;

  Maintenance({
    required this.id,
    required this.deviceName,
    required this.companyName,
    required this.dateSent,
    required this.problemDescription,
    required this.isDone,
    this.companyId,
    this.dateDone,
  });

  Maintenance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceName = json['deviceName'],
        companyName = json['companyName'],
        dateSent = json['dateSent'],
        companyId = json['companyId'],
        dateDone = json['dateDone'],
        isDone = json['isDone'],
        problemDescription = json['problemDescription'];
}
