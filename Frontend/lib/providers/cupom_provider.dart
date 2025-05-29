import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/cupom_model.dart';
import '../services/cupom_service.dart';

class CupomProvider with ChangeNotifier {
  final CupomService cupomService;

  List<CupomModel> _cupons = [];
  bool _carregando = false;
  String? _erro; // Para armazenar possíveis erros

  List<CupomModel> get cupons => _cupons;
  bool get carregando => _carregando;
  String? get erro => _erro; // Expor o erro para a UI

  CupomProvider(this.cupomService);

  /// Carrega os cupons do usuário a partir do [usuarioId].
  Future<void> carregarCuponsDoUsuario(String usuarioId) async {
    _carregando = true;
    _erro = null; // Limpar o erro anterior, se houver
    notifyListeners();

    try {
      _cupons = await cupomService.buscarCuponsUsuario(usuarioId);
      log('🎟️ Cupons carregados: ${_cupons.length}');
    } catch (e, stack) {
      log('❌ Erro ao carregar cupons: $e', stackTrace: stack);
      _cupons = [];
      _erro = 'Não foi possível carregar os cupons. Tente novamente mais tarde.';
    }

    _carregando = false;
    notifyListeners();
  }

  /// Atualiza os cupons localmente, caso necessário.
  void atualizarCupons(List<CupomModel> cuponsNovos) {
    _cupons = cuponsNovos;
    notifyListeners();
  }

  /// Limpa a lista de cupons
  void limparCupons() {
    _cupons = [];
    notifyListeners();
  }
}
