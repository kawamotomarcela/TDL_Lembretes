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

  /// Inicializa a base da URL com base na plataforma
  Future<void> init() async {
    if (kIsWeb) {
      _baseUrl = 'https://localhost:7008/api';
    } else if (Platform.isAndroid || Platform.isIOS) {
      final prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString('ipAddress') ?? '10.0.2.2'; // IP padrão Android emulador
      _baseUrl = 'http://$ip:7008/api';
    } else {
      _baseUrl = 'https://localhost:7008/api';
    }
  }

  Uri _buildUri(String endpoint) => Uri.parse('$_baseUrl$endpoint');

  /// Gera os headers com token JWT, se presente
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  /// GET request com retry e timeout
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

  /// POST request
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

  /// PUT request
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

  /// DELETE request
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

  /// Trata respostas HTTP
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      if (kDebugMode && body.isNotEmpty) {
        log('✅ Response $statusCode: $body');
      }
      return body.isNotEmpty ? jsonDecode(body) : {};
    } else {
      log('❌ Erro HTTP $statusCode: $body');
      // Exibe mensagem de erro detalhada (como erro 400 de validação)
      throw HttpException('Erro $statusCode: $body');
    }
  }

  /// Salva o token JWT
  static Future<void> salvarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Remove o token salvo
  static Future<void> limparToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  /// Verifica se o token está presente
  static Future<bool> isAutenticado() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }
}
