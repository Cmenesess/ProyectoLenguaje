// ignore_for_file: prefer_const_declarations, always_specify_types, unused_element, always_declare_return_types

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  static final String _baseUrl = 'localhost:4000';

  Future<String> _getJsonData(String segment) async {
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url);
    return response.body;
  }

  static loginUser(String correo, String password) async {
    const String segment = '/auth';
    var url = Uri.http(_baseUrl, segment);
    final body = {"correo": correo, "password": password};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static infoClient(String? token) async {
    const String segment = '/users/infoClient';
    var url = Uri.http(_baseUrl, segment);
    final body = {"token": token};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static createUser(String address, String correo, String password) async {
    const String segment = '/users/client';
    var url = Uri.http(_baseUrl, segment);
    final body = {"correo": correo, "telefono": address, "password": password};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }
}
