// ignore_for_file: file_names

class GetSparesOnCase {
  List<Spares>? spares;
  String? code;
  String? message;

  GetSparesOnCase({this.spares, this.code, this.message});

  GetSparesOnCase.fromJson(Map<String, dynamic> json) {
    if (json['spares'] != null) {
      spares = <Spares>[];
      json['spares'].forEach((v) {
        spares!.add(Spares.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (spares != null) {
      data['spares'] = spares!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Spares {
  String? requestID;
  String? submitter;
  String? createDate;
  String? spareCode;
  String? partReplaced;
  String? sparePrice;
  String? spareRID;

  Spares(
      {this.requestID,
        this.submitter,
        this.createDate,
        this.spareCode,
        this.partReplaced,
        this.sparePrice,
        this.spareRID});

  Spares.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    submitter = json['submitter'];
    createDate = json['createDate'];
    spareCode = json['spareCode'];
    partReplaced = json['partReplaced'];
    sparePrice = json['spare_Price'];
    spareRID = json['spare_RID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestID'] = requestID;
    data['submitter'] = submitter;
    data['createDate'] = createDate;
    data['spareCode'] = spareCode;
    data['partReplaced'] = partReplaced;
    data['spare_Price'] = sparePrice;
    data['spare_RID'] = spareRID;
    return data;
  }
}