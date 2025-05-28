import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/produto_model.dart';
import '../services/produto_service.dart';

class ProdutoProvider with ChangeNotifier {
  final ProdutoService produtoService;

  ProdutoProvider(this.produtoService);

  List<ProdutoModel> _produtos = [];
  bool _carregando = false;

  List<ProdutoModel> get produtos => _produtos;
  bool get carregando => _carregando;

  /// Carrega todos os produtos do backend
  Future<void> carregarProdutos() async {
    _carregando = true;
    notifyListeners();

    try {
      _produtos = await produtoService.buscarProdutos();
      log('📦 Total de produtos carregados: ${_produtos.length}');
    } catch (e, stack) {
      log('❌ Erro ao carregar produtos: $e', stackTrace: stack);
      _produtos = [];
    }

    _carregando = false;
    notifyListeners();
  }

  /// Atualiza um único produto localmente com base no ID
  Future<void> atualizarProdutoLocal(String produtoId) async {
    try {
      final produtoAtualizado = await produtoService.buscarProdutoPorId(produtoId);
      final index = _produtos.indexWhere((p) => p.id == produtoId);

      if (index != -1) {
        _produtos[index] = produtoAtualizado;
        log('🔄 Produto atualizado localmente: ${produtoAtualizado.nome}');
      } else {
        log('⚠️ Produto com ID $produtoId não encontrado na lista local');
        _produtos.add(produtoAtualizado); // opcional: adicionar se não estiver presente
      }

      notifyListeners();
    } catch (e, stack) {
      log('❌ Erro ao atualizar produto local: $e', stackTrace: stack);
    }
  }

  /// Atualiza a quantidade localmente (opcional para exibir sem recarregar tudo)
  void atualizarQuantidadeLocal(String produtoId, int novaQuantidade) {
    final index = _produtos.indexWhere((p) => p.id == produtoId);
    if (index != -1) {
      final produto = _produtos[index];
      _produtos[index] = produto.copyWith(quantidadeDisponivel: novaQuantidade);
      log('🔁 Quantidade local do produto "${produto.nome}" atualizada para $novaQuantidade');
      notifyListeners();
    }
  }
}
