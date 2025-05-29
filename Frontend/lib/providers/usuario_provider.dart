import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';
import '../api/api_client.dart';
import '../providers/produto_provider.dart';
import 'dart:developer';

class UsuarioProvider with ChangeNotifier {
  late UsuarioService _usuarioService;
  late ApiClient _apiClient;

  Usuario? _usuario;
  String? _erro;

  Usuario? get usuario => _usuario;
  String? get erro => _erro;

  void setService(UsuarioService service, ApiClient apiClient) {
    _usuarioService = service;
    _apiClient = apiClient;
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
      _erro = 'Erro ao salvar pontos';
    }

    notifyListeners();
  }

  Future<bool> atualizarPerfil({
    required String nome,
    required String telefone,
    required String email,
    String? senha,
  }) async {
    if (_usuario == null) return false;

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

  Future<bool> comprarProduto({
    required String produtoId,
    required int custoTotal,
    required ProdutoProvider produtoProvider,
    int quantidade = 1,
  }) async {
    log(
      'Iniciando compra - produtoId="$produtoId", custoTotal=$custoTotal, quantidade=$quantidade',
    );

    if (_usuario == null || _usuario!.pontos < custoTotal) {
      _erro = 'Pontos insuficientes';
      notifyListeners();
      return false;
    }

    try {
      final payload = {
        'usuarioId': _usuario!.id,
        'produtoId': produtoId,
        'quantidade': quantidade,
      };

      log('📤 POST /Compra - Payload enviado: $payload');

      final response = await _apiClient.post('/Compra', payload);

      if (response['sucesso'] == true) {
        _usuario = _usuario!.copyWith(pontos: _usuario!.pontos - custoTotal);
        await produtoProvider.atualizarProdutoLocal(produtoId);
        notifyListeners();
        return true;
      } else {
        _erro = response['mensagem'] ?? 'Erro ao realizar a compra';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _erro = 'Erro ao realizar a compra: $e';
      notifyListeners();
      return false;
    }
  }
}
