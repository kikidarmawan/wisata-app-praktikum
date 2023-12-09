class LoginResponse {
  final String status;
  final String message;
  final UserData data;
  final String accessToken;
  final String tokenType;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LoginFail {
  final String status;
  final String message;

  LoginFail({
    required this.status,
    required this.message,
  });

  factory LoginFail.fromJson(Map<String, dynamic> json) {
    return LoginFail(
      status: json['status'],
      message: json['message'],
    );
  }
}
