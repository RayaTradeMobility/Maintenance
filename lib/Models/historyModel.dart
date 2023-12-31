// ignore_for_file: file_names

class HistoryModel {
  HeaderInfo? headerInfo;
  String? sumMaintenanceAmount;
  List<Orders>? orders;

  HistoryModel({this.headerInfo, this.sumMaintenanceAmount, this.orders});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
    sumMaintenanceAmount = json['sum_MaintenanceAmount'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
    }
    data['sum_MaintenanceAmount'] = sumMaintenanceAmount;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
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

class Orders {
  String? workOrderID;
  String? workStatus;
  String? maintenanceAmount;
  String? maintenanceFinishTime;

  Orders(
      {this.workOrderID,
      this.workStatus,
      this.maintenanceAmount,
      this.maintenanceFinishTime});

  Orders.fromJson(Map<String, dynamic> json) {
    workOrderID = json['work_order_ID'];
    workStatus = json['work_Status'];
    maintenanceAmount = json['maintenance_Amount'];
    maintenanceFinishTime = json['maintenance_Finish_Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_order_ID'] = workOrderID;
    data['work_Status'] = workStatus;
    data['maintenance_Amount'] = maintenanceAmount;
    data['maintenance_Finish_Time'] = maintenanceFinishTime;
    return data;
  }
}
