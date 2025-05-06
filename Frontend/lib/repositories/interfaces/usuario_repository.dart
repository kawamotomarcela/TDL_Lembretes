import '../../models/usuario_model.dart';

abstract class UsuarioRepository {
  Future<List<Usuario>> getAllUsers();
  Future<void> saveUser(Usuario user);
  Future<void> updateUser(Usuario user);
  Future<void> deleteUser(String id);
}