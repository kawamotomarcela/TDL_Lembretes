import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';

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
      notifyListeners();
      return true;
    } else {
      _erro = 'Erro ao atualizar perfil';
      notifyListeners();
      return false;
    }
  }

  Future<bool> comprarProduto(int custo) async {
    if (_usuario == null) return false;

    if (_usuario!.pontos < custo) {
      _erro = 'Pontos insuficientes';
      notifyListeners();
      return false;
    }

    final novosPontos = _usuario!.pontos - custo;
    final atualizado = _usuario!.copyWith(pontos: novosPontos);

    final sucesso = await _usuarioService.atualizarUsuario(
      atualizado.id,
      atualizado.toJson(),
    );

    if (sucesso) {
      _usuario = atualizado;
      _erro = null;
      notifyListeners();
    }

    return sucesso;
  }
}
