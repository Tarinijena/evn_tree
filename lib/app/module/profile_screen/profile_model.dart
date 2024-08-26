

class UserData {
  final List<Role> roles;
  final String fullName;
  final String? mobileNo;
  final String userName;
  final String email;

  UserData({
    required this.roles,
    required this.fullName,
    this.mobileNo,
    required this.userName,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    var list = json['roles'] as List;
    List<Role> roleList = list.map((i) => Role.fromJson(i)).toList();

    return UserData(
      roles: roleList,
      fullName: json['fullName'],
      mobileNo: json['mobileNo'],
      userName: json['userName'],
      email: json['email'],
    );
  }
}

class Role {
  final String roleTId;
  final String roleCode;
  final String roleName;

  Role({
    required this.roleTId,
    required this.roleCode,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleTId: json['roleTId'],
      roleCode: json['roleCode'],
      roleName: json['roleName'],
    );
  }
}