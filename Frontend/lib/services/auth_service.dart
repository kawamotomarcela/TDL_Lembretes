import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:developer';


class AuthService {
  static String getBaseUrl() {
    if (kIsWeb) {
      return 'https://localhost:7008/api/auth';
    } else if (Platform.isAndroid || Platform.isIOS) {
      return 'https://192.168.1.10:7008/api/auth';
    } else {
      return 'https://localhost:7008/api/auth';
    }
  }

  static Future<String?> login(String email, String senha) async {
    final url = Uri.parse('${getBaseUrl()}/signIn');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 201) {
        return response.body;
      } else {
        log('Erro login: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Erro na conexão: $e');
      return null;
    }
  }

  static Future<String?> register(String nome, String email, String senha, String telefone) async {
    final url = Uri.parse('${getBaseUrl()}/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'senha': senha,
          'telefone': telefone,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['token'];
      } else {
        log('Erro cadastro: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Erro na conexão: $e');
      return null;
    }
  }
}
