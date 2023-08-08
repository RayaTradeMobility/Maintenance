// ignore_for_file: file_names

class LoginModel {
  HeaderInfo? headerInfo;
  User? user;

  LoginModel({this.headerInfo, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class HeaderInfo {
  String? code;
  String? message;

  HeaderInfo({this.code, this.message});

  HeaderInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class User {
  String? mobileUsername;
  String? maintenanceRepName;
  String? siteRequestId;

  User({this.mobileUsername, this.maintenanceRepName, this.siteRequestId});

  User.fromJson(Map<String, dynamic> json) {
    mobileUsername = json['mobile_Username'];
    maintenanceRepName = json['maintenance_RepName'];
    siteRequestId = json['siteRequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_Username'] = mobileUsername;
    data['maintenance_RepName'] = maintenanceRepName;
    data['siteRequestId'] = siteRequestId;
    return data;
  }
}