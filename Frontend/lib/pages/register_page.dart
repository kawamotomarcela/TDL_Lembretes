import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:grupotdl/routes/app_routes.dart';
import 'package:grupotdl/widgets/custom_text_field.dart';
import 'package:grupotdl/widgets/custom_button.dart';
import 'package:grupotdl/utils/show_snackbar.dart';
import 'package:grupotdl/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _register() {
    final username = _usernameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text.replaceAll(RegExp(r'\D'), ''); 
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    final usernameError = Validators.validateRequired(username, "Nome de usuário");
    final emailError = Validators.validateEmail(email);
    final phoneError = Validators.validatePhone(phone);
    final passwordError = Validators.validatePassword(password);
    final confirmPasswordError = Validators.validateConfirmPassword(password, confirmPassword);

    if (usernameError != null) {
      showSnackBar(context, usernameError, color: Colors.red);
      return;
    }

    if (emailError != null) {
      showSnackBar(context, emailError, color: Colors.red);
      return;
    }

    if (phoneError != null) {
      showSnackBar(context, phoneError, color: Colors.red);
      return;
    }

    if (passwordError != null) {
      showSnackBar(context, passwordError, color: Colors.red);
      return;
    }

    if (confirmPasswordError != null) {
      showSnackBar(context, confirmPasswordError, color: Colors.red);
      return;
    }

    showSnackBar(context, "Conta criada com sucesso!");
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Criar Conta',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _usernameController,
                  hintText: "Nome de usuário",
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _phoneController,
                  hintText: "Telefone",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [PhoneInputFormatter()],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Senha",
                  icon: Icons.lock,
                  obscure: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirmar senha",
                  icon: Icons.lock_outline,
                  obscure: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(text: "Criar Conta", onPressed: _register),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                  child: const Text(
                    "Já tem uma conta? Fazer login",
                    style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

