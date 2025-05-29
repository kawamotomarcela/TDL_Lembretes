import 'dart:developer';
import '../api/api_client.dart';
import '../models/cupom_model.dart';

class CupomService {
  final ApiClient api;

  CupomService(this.api);

  Future<List<CupomModel>> buscarCuponsUsuario(String usuarioId) async {
    try {
      final response = await api.get('/Compra/usuario/$usuarioId');
      log('📩 Resposta de cupons: $response');

      if (response is List) {
        return response
            .map((item) => CupomModel.fromMap(item as Map<String, dynamic>))
            .toList();
      } else {
        log('❌ Formato inesperado ao buscar cupons.');
        return [];
      }
    } catch (e, stack) {
      log('❌ Erro ao buscar cupons do usuário: $e', stackTrace: stack);
      return [];
    }
  }
}
