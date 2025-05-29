import 'dart:developer';
import '../api/api_client.dart';

class AuthService {
  final ApiClient _api;

  AuthService(this._api);

  /// LOGIN
  Future<Map<String, dynamic>?> login(String email, String senha) async {
    try {
      final response = await _api.post('/auth/signIn', {
        'email': email,
        'senha': senha,
      });

      if (response != null && response['token'] != null) {
        await ApiClient.salvarToken(response['token']);
        return response; // Retorna token + usuário
      }

      return null;
    } catch (e, stackTrace) {
      log('Erro no login', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// CADASTRO
  Future<bool> register(
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

      if (response != null && response['message'] != null) {
        log('[AuthService] Cadastro: ${response['message']}');
        return true;
      }

      return false;
    } catch (e, stackTrace) {
      log('Erro no cadastro', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await ApiClient.limparToken();
  }

  /// VERIFICA AUTENTICAÇÃO
  Future<bool> isAutenticado() => ApiClient.isAutenticado();
}
