import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late String _baseUrl;
  final _retryOptions = RetryOptions(maxAttempts: 3);

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

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token'); // opcional
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint) async {
    return _retryOptions.retry(
      () async {
        final response = await http
            .get(_buildUri(endpoint), headers: await _getHeaders())
            .timeout(const Duration(seconds: 10));
        return _handleResponse(response);
      },
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    return _retryOptions.retry(
      () async {
        if (kDebugMode) {
          log('POST $endpoint - Payload: $data');
        }
        final response = await http
            .post(
              _buildUri(endpoint),
              headers: await _getHeaders(),
              body: jsonEncode(data),
            )
            .timeout(const Duration(seconds: 10));
        return _handleResponse(response);
      },
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    return _retryOptions.retry(
      () async {
        if (kDebugMode) {
          log('PUT $endpoint - Payload: $data');
        }
        final response = await http
            .put(
              _buildUri(endpoint),
              headers: await _getHeaders(),
              body: jsonEncode(data),
            )
            .timeout(const Duration(seconds: 10));
        return _handleResponse(response);
      },
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
  }

  Future<void> delete(String endpoint) async {
    return _retryOptions.retry(
      () async {
        final response = await http
            .delete(_buildUri(endpoint), headers: await _getHeaders())
            .timeout(const Duration(seconds: 10));
        _handleResponse(response);
      },
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (kDebugMode) {
        log('Response ${response.statusCode}: ${response.body}');
      }
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      log('Erro HTTP ${response.statusCode}: ${response.body}');
      throw HttpException('Erro ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
