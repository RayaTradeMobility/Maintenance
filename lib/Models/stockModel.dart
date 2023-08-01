// ignore_for_file: file_names

class StockModel {
  String? statusCode;
  String? message;
  List<Stock>? stock;

  StockModel({this.statusCode, this.message, this.stock});

  StockModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['stock'] != null) {
      stock = <Stock>[];
      json['stock'].forEach((v) {
        stock!.add(Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (stock != null) {
      data['stock'] = stock!.map((v) => v.toJson()).toList();
    }
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
