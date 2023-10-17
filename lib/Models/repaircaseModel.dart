// ignore_for_file: file_names

class RepairModel {
  HeaderInfo? headerInfo;
  List<RepairCases>? repairCases;

  RepairModel({this.headerInfo, this.repairCases});

  RepairModel.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
    if (json['repairCases'] != null) {
      repairCases = <RepairCases>[];
      json['repairCases'].forEach((v) {
        repairCases!.add(RepairCases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
    }
    if (repairCases != null) {
      data['repairCases'] = repairCases!.map((v) => v.toJson()).toList();
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

class RepairCases {
  String? workOrderID;
  String? primarySerialNumber;
  String? productModel;
  String? brand;
  String? customerName;
  String? mobileNumber;
  String? phoneNumber;
  String? maintenanceRID;
  String? casePriority;

  RepairCases(
      {this.workOrderID,
      this.primarySerialNumber,
      this.productModel,
      this.brand,
      this.customerName,
      this.mobileNumber,
      this.phoneNumber,
      this.maintenanceRID,
      this.casePriority});

  RepairCases.fromJson(Map<String, dynamic> json) {
    workOrderID = json['work_Order_ID'];
    primarySerialNumber = json['primary_Serial_Number'];
    productModel = json['product_Model'];
    brand = json['brand'];
    customerName = json['customerName'];
    mobileNumber = json['mobile_Number'];
    phoneNumber = json['phone_Number'];
    maintenanceRID = json['maintenance_RID'];
    casePriority = json['case_Priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_Order_ID'] = workOrderID;
    data['primary_Serial_Number'] = primarySerialNumber;
    data['product_Model'] = productModel;
    data['brand'] = brand;
    data['customerName'] = customerName;
    data['mobile_Number'] = mobileNumber;
    data['phone_Number'] = phoneNumber;
    data['maintenance_RID'] = maintenanceRID;
    data['case_Priority'] = casePriority;
    return data;
  }
}
