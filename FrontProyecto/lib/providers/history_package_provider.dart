// ignore_for_file: prefer_const_declarations

import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPackageProvider {
  static final String _baseUrl = '192.168.1.6:4000';

  static getHistoryPackages(String token) async {
    const String segment = '/savaPackage/history';
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static getHistoryPackagesByASCOrder(String token) async {
    const String segment = '/savaPackage/orderASCHistory';
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static getHistoryPackagesByDESCOrder(String token) async {
    const String segment = '/savaPackage/orderDESCHistory';
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static getHistoryPackagesBetweenDates(
      String token, String start, String end) async {
    final queryParameters = {
      'start': start,
      'end': end,
    };
    var segment = '/savaPackage/betweenHistory/' + start + "/" + end;
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }
}
