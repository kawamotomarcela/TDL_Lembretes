import 'package:flutter/material.dart';
import '../../../utils/show_snackbar.dart';
import '../../../utils/validators.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "Fulano Legal");
  final _phoneController = TextEditingController(text: "(11) 91234-5678");
  final _emailController = TextEditingController(text: "fulanolegal@email.com");

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      showSnackBar(context, 'Perfil atualizado com sucesso!', color: Colors.green);
    }
  }

  OutlineInputBorder get blackBorder => const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
              prefixIcon: const Icon(Icons.person_outline),
              border: blackBorder,
              enabledBorder: blackBorder,
              focusedBorder: blackBorder,
            ),
            validator: (value) => Validators.validateRequired(value, 'Nome'),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Telefone',
              prefixIcon: const Icon(Icons.phone_outlined),
              border: blackBorder,
              enabledBorder: blackBorder,
              focusedBorder: blackBorder,
            ),
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: blackBorder,
              enabledBorder: blackBorder,
              focusedBorder: blackBorder,
            ),
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Salvar', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
