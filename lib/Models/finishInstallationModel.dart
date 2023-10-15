// ignore_for_file: file_names

class Getinstallation {
  HeaderInfo? headerInfo;

  Getinstallation({this.headerInfo});

  Getinstallation.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
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
