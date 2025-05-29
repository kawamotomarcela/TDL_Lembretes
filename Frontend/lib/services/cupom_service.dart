import '../api/api_client.dart';
import '../models/cupom_model.dart';

class CupomService {
  final ApiClient api;

  CupomService(this.api);

  Future<List<CupomModel>> buscarCuponsUsuario(String usuarioId) async {
    try {
      final response = await api.get('/Cupom/usuario/$usuarioId');

      if (response is List) {
        return response.map((item) => CupomModel.fromMap(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
