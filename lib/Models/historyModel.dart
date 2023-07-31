class HistoryModel {
  String? sumMaintenanceAmount;
  List<Orders>? orders;

  HistoryModel({this.sumMaintenanceAmount, this.orders});

  HistoryModel.fromJson(Map<String, dynamic> json) {
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
    data['sum_MaintenanceAmount'] = sumMaintenanceAmount;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
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