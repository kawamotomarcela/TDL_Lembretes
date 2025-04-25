import 'package:flutter/material.dart';
import 'widgets/profile_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _imageUrl = 'assets/tdl.png';

  void _changeImage() {
    showDialog(
      context: context,
      builder: (context) {
        final urlController = TextEditingController();
        return AlertDialog(
          title: const Text('Nova imagem de perfil'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(hintText: 'Cole a URL da imagem'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  setState(() => _imageUrl = urlController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Atualizar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNetwork = _imageUrl.startsWith('http');

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: isNetwork
                          ? NetworkImage(_imageUrl) as ImageProvider
                          : AssetImage(_imageUrl),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _changeImage,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.edit, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _changeImage,
                  child: const Text(
                    'Selecionar nova imagem',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
                const SizedBox(height: 20),
                const ProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
