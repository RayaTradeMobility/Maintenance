// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maintenance/Models/finishInstallationModel.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Models/stockModel.dart';
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

  Future<StockModel> fetchStock(String mobileUsername) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetStock?SiteRequestId=$mobileUsername'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      return StockModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Stock order data');
    }
  }

  Future<HistoryModel> fetchHistory(String mobileUsername) async {
    final response = await http.get(Uri.parse(
        'http://www.rayatrade.com/TechnicionMobileApi/api/User//GetHistory?SiteRequestId=$mobileUsername'));

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

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return InstallationModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Installation Case data');
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
    if (attachments[0].isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('attacments', attachments[0]));
    }
    if (attachments[1].isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('attacments', attachments[1]));
    }
    if (attachments[2].isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('attacments', attachments[2]));
    }

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return Getinstallation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
