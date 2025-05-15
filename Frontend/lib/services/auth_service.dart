import 'dart:developer';
import '../api/api_client.dart';

class AuthService {
  final ApiClient _api;

  AuthService(this._api);

  Future<Map<String, dynamic>?> login(String email, String senha) async {
    try {
      final response = await _api.post('/auth/signIn', {
        'email': email,
        'senha': senha,
      });
      return response;
    } catch (e, stackTrace) {
      log('Erro no login', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<String?> register(
    String nome,
    String email,
    String senha,
    String telefone,
  ) async {
    try {
      final response = await _api.post('/auth/register', {
        'nome': nome,
        'email': email,
        'senha': senha,
        'telefone': telefone,
      });
      return response['token'];
    } catch (e, stackTrace) {
      log('Erro no cadastro', error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
