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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: isNetwork
                        ? NetworkImage(_imageUrl) as ImageProvider
                        : AssetImage(_imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _changeImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 153, 155, 170),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _changeImage,
              child: const Text(
                'Alterar imagem de perfil',
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const ProfileForm(),
          ],
        ),
      ),
    );
  }
}
