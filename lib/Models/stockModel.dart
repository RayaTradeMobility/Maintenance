// ignore_for_file: file_names

class StockModel {
  HeaderInfo? headerInfo;
  List<Stock>? stock;

  StockModel({this.headerInfo, this.stock});

  StockModel.fromJson(Map<String, dynamic> json) {
    headerInfo = json['headerInfo'] != null
        ? HeaderInfo.fromJson(json['headerInfo'])
        : null;
    if (json['stock'] != null) {
      stock = <Stock>[];
      json['stock'].forEach((v) {
        stock!.add(Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerInfo != null) {
      data['headerInfo'] = headerInfo!.toJson();
    }
    if (stock != null) {
      data['stock'] = stock!.map((v) => v.toJson()).toList();
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

class Stock {
  String? partNumber;
  String? spareDescription;
  String? currentQty;

  Stock({this.partNumber, this.spareDescription, this.currentQty});

  Stock.fromJson(Map<String, dynamic> json) {
    partNumber = json['partNumber'];
    spareDescription = json['spareDescription'];
    currentQty = json['currentQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partNumber'] = partNumber;
    data['spareDescription'] = spareDescription;
    data['currentQty'] = currentQty;
    return data;
  }
}
