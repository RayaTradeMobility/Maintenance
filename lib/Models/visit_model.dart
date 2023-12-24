class VisitModel {
  List<TechVisits>? techVisits;
  String? code;
  String? message;

  VisitModel({this.techVisits, this.code, this.message});

  VisitModel.fromJson(Map<String, dynamic> json) {
    if (json['techVisits'] != null) {
      techVisits = <TechVisits>[];
      json['techVisits'].forEach((v) {
        techVisits!.add(TechVisits.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (techVisits != null) {
      data['techVisits'] = techVisits!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class TechVisits {
  String? requestID;
  String? model;
  String? gspn;
  String? symptom;
  String? customerName;
  String? customerMobile;
  String? address;
  String? priority;
  String? serialNumber;
  String? spareParts;
  String? warrantyStatus;

  TechVisits(
      {this.requestID,
      this.model,
      this.gspn,
      this.symptom,
      this.customerName,
      this.customerMobile,
      this.address,
      this.priority,
      this.serialNumber,
      this.spareParts,
      this.warrantyStatus});

  TechVisits.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    model = json['model'];
    gspn = json['gspn'];
    symptom = json['symptom'];
    customerName = json['customerName'];
    customerMobile = json['customerMobile'];
    address = json['address'];
    priority = json['priority'];
    serialNumber = json['serialNumber'];
    spareParts = json['spareParts'];
    warrantyStatus = json['warrantyStatus'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestID'] = requestID;
    data['model'] = model;
    data['gspn'] = gspn;
    data['symptom'] = symptom;
    data['customerName'] = customerName;
    data['customerMobile'] = customerMobile;
    data['address'] = address;
    data['priority'] = priority;
    data['serialNumber'] = serialNumber;
    data['spareParts'] = spareParts;
    data['warrantyStatus'] = warrantyStatus;
    return data;
  }
}
