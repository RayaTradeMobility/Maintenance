// ignore_for_file: file_names

class InstallationModel {
  String? code;
  String? message;
  List<InstallationCases>? installationCases;

  InstallationModel({this.code, this.message, this.installationCases});

  InstallationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['installationCases'] != null) {
      installationCases = <InstallationCases>[];
      json['installationCases'].forEach((v) {
        installationCases!.add(InstallationCases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (installationCases != null) {
      data['installationCases'] =
          installationCases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstallationCases {
  String? customerFullName;
  String? mobileNumber;
  String? phoneNumber;
  String? city;
  String? address;
  String? symptom;
  String? model;
  String? serial;
  String? category;
  String? brand;
  String? symptomCategory;

  InstallationCases(
      {this.customerFullName,
        this.mobileNumber,
        this.phoneNumber,
        this.city,
        this.address,
        this.symptom,
        this.model,
        this.serial,
        this.category,
        this.brand,
        this.symptomCategory});

  InstallationCases.fromJson(Map<String, dynamic> json) {
    customerFullName = json['customerFullName'];
    mobileNumber = json['mobileNumber'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    address = json['address'];
    symptom = json['symptom'];
    model = json['model'];
    serial = json['serial'];
    category = json['category'];
    brand = json['brand'];
    symptomCategory = json['symptomCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerFullName'] = customerFullName;
    data['mobileNumber'] = mobileNumber;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['address'] = address;
    data['symptom'] = symptom;
    data['model'] = model;
    data['serial'] = serial;
    data['category'] = category;
    data['brand'] = brand;
    data['symptomCategory'] = symptomCategory;
    return data;
  }
}