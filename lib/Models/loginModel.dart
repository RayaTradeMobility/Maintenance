// ignore_for_file: file_names

class LoginModel {
  final String username;
  final String password;
  final String status;
  final String siteRequestId;

  LoginModel({
    required this.username,
    required this.password,
    required this.status,
    required this.siteRequestId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json['username'],
      password: json['password'],
      status: json['status'],
      siteRequestId: json['siteRequestId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'status': status,
      'siteRequestId': siteRequestId,
    };
  }
}