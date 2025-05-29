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

  /// 🔄 Carrega todos os produtos disponíveis na loja
  Future<void> carregarProdutos() async {
    _carregando = true;
    notifyListeners();

    try {
      _produtos = await produtoService.buscarProdutos();
      log('📦 Total de produtos carregados: ${_produtos.length}');
      for (final produto in _produtos) {
        log('🔍 Produto: id=${produto.id}, nome=${produto.nome}');
      }
    } catch (e, stack) {
      log('❌ Erro ao carregar produtos: $e', stackTrace: stack);
      _produtos = [];
    }

    _carregando = false;
    notifyListeners();
  }

  /// 🔄 Atualiza localmente um produto específico, via backend
  Future<void> atualizarProdutoLocal(String produtoId) async {
    try {
      final produtoAtualizado = await produtoService.buscarProdutoPorId(produtoId);
      final index = _produtos.indexWhere((p) => p.id == produtoId);

      if (index != -1) {
        _produtos[index] = produtoAtualizado;
        log('🔄 Produto atualizado localmente: ${produtoAtualizado.nome}');
        notifyListeners();
      }
    } catch (e, stack) {
      log('❌ Erro ao atualizar produto local: $e', stackTrace: stack);
    }
  }

  /// 🔢 Atualiza a quantidade de um produto na lista local
  void atualizarQuantidadeLocal(String produtoId, int novaQuantidade) {
    final index = _produtos.indexWhere((p) => p.id == produtoId);
    if (index != -1) {
      final produto = _produtos[index];
      _produtos[index] = produto.copyWith(quantidadeDisponivel: novaQuantidade);
      log('📉 Quantidade local atualizada para ${produto.nome}: $novaQuantidade');
      notifyListeners();
    }
  }

  /// 🎟️ Retorna a lista de produtos comprados por um usuário (cupons)
  Future<List<ProdutoModel>> carregarProdutosComprados(String usuarioId) async {
    try {
      final cupons = await produtoService.buscarProdutosComprados(usuarioId);
      log('🎫 Produtos comprados carregados: ${cupons.length}');
      return cupons;
    } catch (e) {
      log('❌ Erro ao buscar cupons: $e');
      return [];
    }
  }
}
