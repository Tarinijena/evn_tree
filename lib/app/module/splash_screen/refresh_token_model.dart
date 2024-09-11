class UserResponse {
  final Data? data;
  final bool status;

  UserResponse({this.data, required this.status});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'status': status,
    };
  }
}

class Data {
  final List<Role> roles;
  final String fullName;
  final String? mobileNo;
  final String userName;
  final String email;
  final String token;
  final String refreshToken;

  Data({
    required this.roles,
    required this.fullName,
    this.mobileNo,
    required this.userName,
    required this.email,
    required this.token,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var rolesList = json['roles'] as List;
    List<Role> roles = rolesList.map((role) => Role.fromJson(role)).toList();

    return Data(
      roles: roles,
      fullName: json['fullName'],
      mobileNo: json['mobileNo'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roles': roles.map((role) => role.toJson()).toList(),
      'fullName': fullName,
      'mobileNo': mobileNo,
      'userName': userName,
      'email': email,
      'token': token,
      'refreshToken': refreshToken,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'roleTId': roleTId,
      'roleCode': roleCode,
      'roleName': roleName,
    };
  }
}