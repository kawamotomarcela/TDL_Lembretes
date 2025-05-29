import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/produto_model.dart';
import '../services/produto_service.dart';

class ProdutoProvider with ChangeNotifier {
  final ProdutoService produtoService;
  List<ProdutoModel> _produtos = [];
  bool _carregando = false;

  ProdutoProvider(this.produtoService);

  List<ProdutoModel> get produtos => _produtos;
  bool get carregando => _carregando;

  Future<void> carregarProdutos() async {
    _carregando = true;
    notifyListeners();

    try {
      _produtos = await produtoService.buscarProdutos();
      log('Total de produtos carregados: ${_produtos.length}');
      for (final produto in _produtos) {
        log('Produto: id=${produto.id}, nome=${produto.nome}');
      }
    } catch (e, stack) {
      log('Erro ao carregar produtos: $e', stackTrace: stack);
      _produtos = [];
    }

    _carregando = false;
    notifyListeners();
  }

  Future<void> atualizarProdutoLocal(String produtoId) async {
    try {
      final produtoAtualizado = await produtoService.buscarProdutoPorId(produtoId);
      final index = _produtos.indexWhere((p) => p.id == produtoId);

      if (index != -1) {
        _produtos[index] = produtoAtualizado;
        log('Produto atualizado localmente: ${produtoAtualizado.nome}');
      }
    } catch (e, stack) {
      log('Erro ao atualizar produto local: $e', stackTrace: stack);
    }
    notifyListeners();
  }
}
