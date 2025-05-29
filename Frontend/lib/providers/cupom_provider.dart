import 'package:flutter/material.dart';
import '../models/cupom_model.dart';
import '../services/cupom_service.dart';

class CupomProvider with ChangeNotifier {
  final CupomService cupomService;

  List<CupomModel> _cupons = [];
  bool _carregando = false;

  List<CupomModel> get cupons => _cupons;
  bool get carregando => _carregando;

  CupomProvider(this.cupomService);

  Future<void> carregarCuponsDoUsuario(String usuarioId) async {
    _carregando = true;
    notifyListeners();

    _cupons = await cupomService.buscarCuponsUsuario(usuarioId);
    _carregando = false;
    notifyListeners();
  }
}
