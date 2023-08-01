// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maintenance/Models/stockModel.dart';
import '../Models/historyModel.dart';
import '../Models/loginModel.dart';

class API{

  login( String username, String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://www.rayatrade.com/TechnicionMobileApi/api/User/Login'));
    request.body = json.encode({
      "username": username,
      "password": password
    });
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
    final response = await http.get(Uri.parse('http://www.rayatrade.com/TechnicionMobileApi/api/User/GetStock?SiteRequestId=$siteRequestId'));

    if (response.statusCode == 200) {
      final Map<String , dynamic> jsonMap = json.decode(response.body);

     return StockModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Stock order data');
    }
  }

  Future<HistoryModel> fetchHistory(String siteRequestId) async {
    final response = await http.get(Uri.parse('http://www.rayatrade.com/TechnicionMobileApi/api/User//GetHistory?SiteRequestId=$siteRequestId'));

    if (response.statusCode == 200) {
      final Map<String , dynamic> jsonMap = json.decode(response.body);

      return HistoryModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load Stock order data');
    }
  }


}
