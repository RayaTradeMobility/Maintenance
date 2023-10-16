// ignore_for_file: file_names

class GetOrderRID {
  String? workOrderID;
  String? siteRequestId;
  List<SpareRIDs>? spareRIDs;
  String? maintenanceRID;
  String? username;

  GetOrderRID(
      {this.workOrderID,
        this.siteRequestId,
        this.spareRIDs,
        this.maintenanceRID,
        this.username});

  GetOrderRID.fromJson(Map<String, dynamic> json) {
    workOrderID = json['work_Order_ID'];
    siteRequestId = json['siteRequestId'];
    if (json['spare_RIDs'] != null) {
      spareRIDs = <SpareRIDs>[];
      json['spare_RIDs'].forEach((v) {
        spareRIDs!.add(SpareRIDs.fromJson(v));
      });
    }
    maintenanceRID = json['maintenance_RID'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_Order_ID'] = workOrderID;
    data['siteRequestId'] = siteRequestId;
    if (spareRIDs != null) {
      data['spare_RIDs'] = spareRIDs!.map((v) => v.toJson()).toList();
    }
    data['maintenance_RID'] = maintenanceRID;
    data['username'] = username;
    return data;
  }
}

class SpareRIDs {
  String? spareRID;
  int? sparetype;
  int? repairIN;

  SpareRIDs({this.spareRID, this.sparetype, this.repairIN});

  SpareRIDs.fromJson(Map<String, dynamic> json) {
    spareRID = json['spare_RID'];
    sparetype = json['sparetype'];
    repairIN = json['repairIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spare_RID'] = spareRID;
    data['sparetype'] = sparetype;
    data['repairIN'] = repairIN;
    return data;
  }
}