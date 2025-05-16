import 'package:flutter/material.dart';
import '../models/usuario_model.dart';

class UsuarioProvider with ChangeNotifier {
  Usuario? _usuario;
  String? _erro;

  Usuario? get usuario => _usuario;
  String? get erro => _erro;

  void setUsuario(Usuario novoUsuario) {
    _erro = null;
    _usuario = novoUsuario;
    notifyListeners();
  }

  void atualizarPontos(int novosPontos) {
    if (_usuario != null) {
      _usuario = Usuario(
        id: _usuario!.id,
        nome: _usuario!.nome,
        email: _usuario!.email,
        telefone: _usuario!.telefone,
        pontos: novosPontos,
      );
      notifyListeners();
    } else {
      _erro = 'Usuário não encontrado';
      notifyListeners();
    }
  }

  void limparUsuario() {
    _usuario = null;
    notifyListeners();
  }
}
