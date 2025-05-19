import 'dart:developer';
import '../api/api_client.dart';

class UsuarioService {
  final ApiClient api;

  UsuarioService(this.api);

  Future<bool> atualizarUsuario(String id, Map<String, dynamic> dados, {String? senha}) async {
    try {
      final payload = Map<String, dynamic>.from(dados);

      if (senha != null && senha.isNotEmpty) {
        payload['Senha'] = senha; 
      }

      log('Payload update: $payload');

      await api.put('/Usuario/$id', payload);
      return true;
    } catch (e, stack) {
      log('Erro ao atualizar usuário', error: e, stackTrace: stack);
      return false;
    }
  }
}


