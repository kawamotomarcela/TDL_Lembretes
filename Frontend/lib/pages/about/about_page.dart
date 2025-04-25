import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/tdl.png'), 
            ),
            const SizedBox(height: 12),
            const Text(
              'TDL LEMBRETES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Versão 1.0.0',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Divider(height: 32),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Descrição'),
              subtitle: Text(
                'Este aplicativo foi criado para ajudar você a gerenciar tarefas diárias, organizar sua rotina e aumentar sua produtividade.',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Desenvolvedor'),
              subtitle: Text('Equipe TDL Solutions'),
            ),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Contato'),
              subtitle: Text('contato@tdlapp.com'),
            ),
            const Spacer(),
            const Text(
              '© 2025 TDL Solutions. Todos os direitos reservados.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
