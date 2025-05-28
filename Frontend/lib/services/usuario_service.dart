import 'dart:developer';
import '../api/api_client.dart';

class UsuarioService {
  final ApiClient api;

  UsuarioService(this.api);

  Future<bool> atualizarUsuario(
    String id,
    Map<String, dynamic> dados, {
    String? senha,
  }) async {
    try {
      final payload = Map<String, dynamic>.from(dados);

      payload.remove('id');
      payload.remove('pontos');

      if (senha != null && senha.isNotEmpty) {
        payload['Senha'] = senha;
      }

      log('📤 Atualizando perfil do usuário $id: $payload');
      await api.put('/Usuario/$id', payload);

      return true;
    } catch (e, stack) {
      log('❌ Erro ao atualizar usuário', error: e, stackTrace: stack);
      return false;
    }
  }

  Future<bool> atualizarPontosUsuario(String id, int pontos) async {
    try {
      log('📤 Atualizando pontos do usuário $id: $pontos');
      await api.put('/Usuario/$id/pontos', {'pontos': pontos});
      return true;
    } catch (e, stack) {
      log('❌ Erro ao atualizar pontos', error: e, stackTrace: stack);
      return false;
    }
  }
}
