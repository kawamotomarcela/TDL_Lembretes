import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';
import '../../../utils/show_snackbar.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();

  bool _camposPreenchidos = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_camposPreenchidos) {
      final usuario = context.read<UsuarioProvider>().usuario;
      _nomeController.text = usuario?.nome ?? '';
      _telefoneController.text = usuario?.telefone ?? '';
      _emailController.text = usuario?.email ?? '';
      _camposPreenchidos = true;
    }
  }

  Future<void> _saveProfile() async {
    final usuarioProvider = context.read<UsuarioProvider>();
    final usuario = usuarioProvider.usuario;

    if (usuario == null) {
      log('Usuário não encontrado no provider');
      return;
    }

    final nome = _nomeController.text.trim();
    final telefone = _telefoneController.text.trim();
    final email = _emailController.text.trim();
    final senhaAtual = _senhaAtualController.text.trim();
    final novaSenha = _novaSenhaController.text.trim();

    // Logs de debug antes de enviar
    log(' Salvando perfil:');
    log('   Nome: $nome');
    log('   Email: $email');
    log('   Telefone: $telefone');
    log('   Senha atual: ${senhaAtual.isNotEmpty ? "preenchida" : "vazia"}');
    log('   Nova senha: ${novaSenha.isNotEmpty ? "preenchida" : "vazia"}');

    final sucesso = await usuarioProvider.atualizarPerfil(
      nome: nome,
      telefone: telefone,
      email: email,
      senhaAtual: senhaAtual.isNotEmpty ? senhaAtual : null,
      novaSenha: novaSenha.isNotEmpty ? novaSenha : null,
    );

    if (!mounted) return;

    if (sucesso) {
      showSnackBar(context, 'Perfil atualizado com sucesso');
      _senhaAtualController.clear();
      _novaSenhaController.clear();
    } else {
      showSnackBar(context, 'Erro ao atualizar perfil', color: Colors.red);
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: inputDecoration('Nome'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: inputDecoration('E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefoneController,
              decoration: inputDecoration('Telefone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _senhaAtualController,
              decoration: inputDecoration('Senha atual'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _novaSenhaController,
              decoration: inputDecoration('Nova senha (opcional)'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

