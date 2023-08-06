class LoginModel {
  String? mobileUsername;
  String? maintenanceRepName;

  LoginModel({ this.mobileUsername, this.maintenanceRepName});

  LoginModel.fromJson(Map<String, dynamic> json) {
    mobileUsername = json['mobile_Username'];
    maintenanceRepName = json['maintenance_RepName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_Username'] = mobileUsername;
    data['maintenance_RepName'] = maintenanceRepName;
    return data;
  }
}