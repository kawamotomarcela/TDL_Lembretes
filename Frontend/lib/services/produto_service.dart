import 'dart:developer';
import '../api/api_client.dart';
import '../models/produto_model.dart';

class ProdutoService {
  final ApiClient api;

  ProdutoService(this.api);

  /// Busca todos os produtos disponíveis
  Future<List<ProdutoModel>> buscarProdutos() async {
    try {
      final response = await api.get('/Produto');
      log('📦 Produtos recebidos do backend: $response');

      if (response is List) {
        return response
            .map((item) => ProdutoModel.fromMap(item as Map<String, dynamic>))
            .toList();
      } else {
        log('❌ Formato inesperado da resposta de produtos');
        return [];
      }
    } catch (e, stack) {
      log('❌ Erro ao buscar produtos: $e', stackTrace: stack);
      return [];
    }
  }

  /// Busca um único produto pelo ID
  Future<ProdutoModel> buscarProdutoPorId(String id) async {
    try {
      final response = await api.get('/Produto/$id');
      log('📦 Produto atualizado recebido: $response');

      if (response is Map<String, dynamic>) {
        return ProdutoModel.fromMap(response);
      } else {
        throw Exception('Formato de resposta inválido ao buscar produto por ID');
      }
    } catch (e, stack) {
      log('❌ Erro ao buscar produto por ID: $e', stackTrace: stack);
      rethrow;
    }
  }
}
