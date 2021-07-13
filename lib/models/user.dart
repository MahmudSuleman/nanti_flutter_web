class User {
  String id;

  String username;

  String companyId;

  User({
    required this.id,
    required this.username,
    required this.companyId,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        companyId = json['companyId'];
}
