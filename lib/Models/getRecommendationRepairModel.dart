// ignore_for_file: file_names

class RecommendationModel {
  HeaderInfo? headerInfo;
  List<Spares>? spares;

  RecommendationModel({this.headerInfo, this.spares});

  RecommendationModel.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
    if (json['spares'] != null) {
      spares = <Spares>[];
      json['spares'].forEach((v) {
        spares!.add(Spares.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
    }
    if (spares != null) {
      data['spares'] = spares!.map((v) => v.toJson()).toList();
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

class Spares {
  String? model;
  String? offering;
  String? spareCode;
  String? spareDescription;
  String? ccTReference;
  String? cost;
  String? finalPrice;
  String? campaignFinalPrice;
  String? serviceCode;
  String? serviceLevel;
  String? repairModule;

  Spares(
      {this.model,
      this.offering,
      this.spareCode,
      this.spareDescription,
      this.ccTReference,
      this.cost,
      this.finalPrice,
      this.campaignFinalPrice,
      this.serviceCode,
      this.serviceLevel,
      this.repairModule});

  Spares.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    offering = json['offering'];
    spareCode = json['spare_Code'];
    spareDescription = json['spare_Description'];
    ccTReference = json['ccT_Reference'];
    cost = json['cost'];
    finalPrice = json['final_Price'];
    campaignFinalPrice = json['campaign_Final_Price'];
    serviceCode = json['service_Code'];
    serviceLevel = json['service_Level'];
    repairModule = json['repair_Module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['offering'] = offering;
    data['spare_Code'] = spareCode;
    data['spare_Description'] = spareDescription;
    data['ccT_Reference'] = ccTReference;
    data['cost'] = cost;
    data['final_Price'] = finalPrice;
    data['campaign_Final_Price'] = campaignFinalPrice;
    data['service_Code'] = serviceCode;
    data['service_Level'] = serviceLevel;
    data['repair_Module'] = repairModule;
    return data;
  }
}
