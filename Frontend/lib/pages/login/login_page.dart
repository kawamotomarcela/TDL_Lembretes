import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import 'widgets/custom_text_field.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/logo_widget.dart';
import '../../utils/show_snackbar.dart';
import '../../services/auth_service.dart';
import '../../api/api_client.dart';
import '../../models/usuario_model.dart';
import '../../providers/usuario_provider.dart';
import 'widgets/ip_config_dialog.dart';

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
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
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
          showSnackBar(
            context,
            "Login inválido ou dados incorretos!",
            color: Colors.red,
          );
        }
      } catch (e, stack) {
        debugPrint('Erro inesperado: $e\n$stack');
        showSnackBar(
          context,
          "Erro inesperado no login!",
          color: Colors.red,
        );
      }
    } else {
      showSnackBar(
        context,
        "Preencha todos os campos!",
        color: Colors.red,
      );
    }
  }

  void _openIpDialog() {
    showDialog(
      context: context,
      builder: (_) => const IpConfigDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_ethernet, color: Colors.white),
            tooltip: "Configurar IP",
            onPressed: _openIpDialog,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF1D4ED8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LogoWidget(title: "TDLembretes"),
                    const SizedBox(height: 8),
                    Text(
                      "Organize sua rotina com facilidade",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.97),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Senha",
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
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
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: primaryBlue,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Lembrar-me",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withValues(alpha: 0.97),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.97),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    CustomButton(
                      text: "Entrar",
                      onPressed: _login,
                    ),
                    const SizedBox(height: 18),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        "Não tem uma conta? Registre-se",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
