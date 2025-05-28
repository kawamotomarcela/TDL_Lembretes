import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';
import '../providers/produto_provider.dart';

class UsuarioProvider with ChangeNotifier {
  late UsuarioService _usuarioService;

  Usuario? _usuario;
  String? _erro;

  Usuario? get usuario => _usuario;
  String? get erro => _erro;

  void setService(UsuarioService service) {
    _usuarioService = service;
  }

  void setUsuario(Usuario novoUsuario) {
    _erro = null;
    _usuario = novoUsuario;
    notifyListeners();
  }

  void limparUsuario() {
    _usuario = null;
    notifyListeners();
  }

  void atualizarPontos(int novosPontos) {
    if (_usuario != null) {
      _usuario = _usuario!.copyWith(pontos: novosPontos);
      notifyListeners();
    } else {
      _erro = 'Usuário não encontrado';
      notifyListeners();
    }
  }

  Future<void> adicionarPontos(int pontos) async {
    if (_usuario == null) {
      _erro = 'Usuário não encontrado';
      notifyListeners();
      return;
    }

    final novosPontos = _usuario!.pontos + pontos;

    final sucesso = await _usuarioService.atualizarPontosUsuario(
      _usuario!.id,
      novosPontos,
    );

    if (sucesso) {
      _usuario = _usuario!.copyWith(pontos: novosPontos);
      _erro = null;
    } else {
      _erro = 'Erro ao salvar pontos no servidor';
    }

    notifyListeners();
  }

  Future<bool> atualizarPerfil({
    required String nome,
    required String telefone,
    required String email,
    String? senha,
  }) async {
    if (_usuario == null) {
      _erro = 'Usuário não carregado';
      notifyListeners();
      return false;
    }

    final atualizado = _usuario!.copyWith(
      nome: nome,
      telefone: telefone,
      email: email,
    );

    final sucesso = await _usuarioService.atualizarUsuario(
      atualizado.id,
      atualizado.toJson(),
      senha: senha,
    );

    if (sucesso) {
      _usuario = atualizado;
      _erro = null;
    } else {
      _erro = 'Erro ao atualizar perfil';
    }

    notifyListeners();
    return sucesso;
  }

  Future<bool> comprarProdutoComProdutoProvider({
    required int custo,
    required String produtoId,
    required int quantidadeAtual,
    required ProdutoProvider produtoProvider,
  }) async {
    if (_usuario == null) {
      _erro = 'Usuário não encontrado';
      notifyListeners();
      return false;
    }

    if (_usuario!.pontos < custo) {
      _erro = 'Pontos insuficientes';
      notifyListeners();
      return false;
    }

    final novosPontos = _usuario!.pontos - custo;
    final novaQuantidade = quantidadeAtual - 1;

    try {
      // Atualiza pontos do usuário
      final sucessoPontos = await _usuarioService.atualizarPontosUsuario(
        _usuario!.id,
        novosPontos,
      );

      if (!sucessoPontos) {
        _erro = 'Erro ao salvar pontos no servidor';
        notifyListeners();
        return false;
      }

      // Atualiza quantidade do produto no backend
      await produtoProvider.produtoService.atualizarQuantidadeProduto(
        produtoId,
        novaQuantidade,
      );

      // Atualiza localmente
      _usuario = _usuario!.copyWith(pontos: novosPontos);
      produtoProvider.atualizarQuantidadeLocal(produtoId, novaQuantidade);

      _erro = null;
      notifyListeners();
      return true;
    } catch (e) {
      _erro = 'Erro ao realizar a compra: $e';
      notifyListeners();
      return false;
    }
  }
}
