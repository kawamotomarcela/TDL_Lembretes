import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late String _baseUrl;

  Future<void> init() async {
    if (kIsWeb) {
      _baseUrl = 'https://localhost:7008/api';
    } else if (Platform.isAndroid || Platform.isIOS) {
      final prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString('ipAddress') ?? '000.000.000'; //COLOCA IP AQUI
      _baseUrl = 'http://$ip:7008/api';
    } else {
      _baseUrl = 'https://localhost:7008/api';
    }
  }

  Uri _buildUri(String endpoint) => Uri.parse('$_baseUrl$endpoint');

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(_buildUri(endpoint));
      return _handleResponse(response);
    } catch (e) {
      log('Erro GET $endpoint: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        _buildUri(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Erro POST $endpoint: $e');
      rethrow;
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        _buildUri(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Erro PUT $endpoint: $e');
      rethrow;
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final response = await http.delete(_buildUri(endpoint));
      _handleResponse(response);
    } catch (e) {
      log('Erro DELETE $endpoint: $e');
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      log('Erro HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
