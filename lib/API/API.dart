// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance/Models/finishInstallationModel.dart';
import 'package:maintenance/Models/getRecommendationRepairModel.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Models/repaircaseModel.dart';
import 'package:maintenance/Models/stockModel.dart';
import '../Models/get_order_model.dart';
import '../Models/historyModel.dart';
import '../Models/loginModel.dart';

class API {
  login(String username, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://www.rayatrade.com/TechnicionMobileApi/api/User/Login'));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<StockModel> fetchStock(String siteRequestId) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetStock?SiteRequestId=$siteRequestId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      return StockModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Stock order data');
    }
  }

  Future<HistoryModel> fetchHistory(String siteRequestId) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User//GetHistory?SiteRequestId=$siteRequestId'));

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      return HistoryModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load History order data');
    }
  }

  Future<InstallationModel> fetchInstallation(String mobileUsername) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetInstallationCases?MobileUsername=$mobileUsername'));

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      return InstallationModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Installation Case data');
    }
  }

  Future<RecommendationModel> fetchRepairCases(
      String workOrderID, String siteRequestId) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetRecommendedStock?Work_Order_ID=$workOrderID&Site_Request_ID=$siteRequestId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return RecommendationModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Repair recommend data');
    }
  }

  Future<RepairModel> fetchRepair(String siteRequestId) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetRepairCases?SiteRequestId=$siteRequestId'));

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return RepairModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Repair Case data');
    }
  }

  getInstallationCase(String requestID, String mobileUsername, String serialIn,
      String serialOut, String comment, List<String> attachments) async {
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://www.rayatrade.com/TechnicionMobileApi/api/User/FinishInstallationCases?RequestId=$requestID'
            '&MobileUsername=$mobileUsername&SerialIn=$serialIn&SerialOut=$serialOut&Comments=$comment'));
    for (var attachmentPath in attachments) {
      if (attachmentPath.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('attachments', attachmentPath));
      }
    }

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      print('Print ${response.statusCode}');
      print(response.body);
      print(request.headers);
      print(request.files);
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('ok');
      }
      return Getinstallation.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print('Print ${response.statusCode}');
        print(response.body);
        print(request.headers);
        print(request.files);
      }

      throw Exception('Failed to post data');
    }
  }

  Future<GetOrder> saveOrderOneBulk(
      String workOrderID,
      String siteRequestID,
      List<String> selectedSpareCode,
      String maintenanceRID,
      String userName,
      int spareType,
      int repairIN) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://www.rayatrade.com/TechnicionMobileApi/api/User/FinishRepairCases'));
    request.body = json.encode({
      "work_Order_ID": workOrderID,
      "siteRequestId": siteRequestID,
      "spare_RIDs": selectedSpareCode,
      "maintenance_RID": maintenanceRID,
      "username": userName,
      "sparetype": spareType,
      "repairIN": repairIN
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(request.body);
        print(response.body);
      }
      return GetOrder.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(request.body);
        print(response.body);
      }

      throw Exception('Failed to get data');
    }
  }
}
