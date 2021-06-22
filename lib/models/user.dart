class User {
  String id;

  String username;

  String userType;

  String companyId;

  User({
    required this.id,
    required this.username,
    required this.userType,
    required this.companyId,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        userType = json['userType'],
        companyId = json['companyId'];
}
