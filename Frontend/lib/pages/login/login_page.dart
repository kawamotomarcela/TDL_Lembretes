import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'widgets/custom_text_field.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/logo_widget.dart';
import '../../utils/show_snackbar.dart';
import '../../services/auth_service.dart';
import '../../api/api_client.dart';
import 'package:provider/provider.dart';
import '../../models/usuario_model.dart';
import '../../providers/usuario_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  void _login() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      try {
        final apiClient = ApiClient();
        await apiClient.init();
        final authService = AuthService(apiClient);

        final response = await authService.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (!mounted) return;

        if (response != null) {
          final usuario = Usuario.fromMap(response);
          context.read<UsuarioProvider>().setUsuario(usuario);
          Navigator.pushReplacementNamed(context, AppRoutes.main);
        } else {
          showSnackBar(context, "Login inválido ou dados incorretos!", color: Colors.red);
        }
      } catch (e, stack) {
        debugPrint('Erro inesperado: $e\n$stack');
        showSnackBar(context, "Erro inesperado no login!", color: Colors.red);
      }
    } else {
      showSnackBar(context, "Preencha todos os campos!", color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const LogoWidget(title: "TDL-Lembretes"),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hintText: "Senha",
                icon: Icons.lock,
                obscure: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) => setState(() => _rememberMe = value!),
                        checkColor: Colors.indigo,
                        activeColor: Colors.white,
                      ),
                      const Text("Lembrar-me", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Esqueceu a senha?",
                      style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomButton(text: "Login", onPressed: _login),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                child: const Text(
                  "Não tem uma conta? Registre-se",
                  style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
