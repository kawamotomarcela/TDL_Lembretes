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

  InputDecoration _inputDecoration(BuildContext context, String label) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.35),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primary, width: 1.8),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final textColor = theme.colorScheme.onSurface;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Text(
              'Dados pessoais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Atualize seu nome, contato e e-mail.',
              style: TextStyle(
                fontSize: 13,
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _nomeController,
              decoration: _inputDecoration(context, 'Nome'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration(context, 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _telefoneController,
              decoration: _inputDecoration(context, 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Text(
              'Segurança',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Altere sua senha se desejar.',
              style: TextStyle(
                fontSize: 13,
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _senhaAtualController,
              decoration: _inputDecoration(context, 'Senha atual'),
              obscureText: true,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _novaSenhaController,
              decoration:
                  _inputDecoration(context, 'Nova senha (opcional)'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saveProfile,
                style: FilledButton.styleFrom(
                  backgroundColor: primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Salvar alterações',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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


