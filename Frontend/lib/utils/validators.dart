class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email é obrigatório';
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < 6) return 'A senha deve ter ao menos 6 caracteres';
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName é obrigatório';
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (password != confirmPassword) return 'As senhas não coincidem';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Telefone é obrigatório';

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != 10 && digitsOnly.length != 11) {
      return 'Telefone deve conter DDD e número válido';
    }

    final ddd = int.tryParse(digitsOnly.substring(0, 2));
    if (ddd == null || ddd < 11 || ddd > 99) {
      return 'DDD inválido';
    }

    if (digitsOnly.length == 11 && digitsOnly[2] != '9') {
      return 'Número de celular deve começar com 9';
    }

    return null;
  }
}

