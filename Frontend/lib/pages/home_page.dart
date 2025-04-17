import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'task_list_page.dart';
import 'reminders_page.dart';
import 'store_page.dart';
import '../routes/app_routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Text(
        'Página Inicial',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const TaskListPage(),
    const PaginaLembrete(),
    const CalendarPage(),
    LojaPage(), 
  ];

  final List<String> _titles = [
    'Página Inicial',
    'Tarefas',
    'Lembretes',
    'Calendário',
    'Loja',
  ];

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Deseja sair?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: const Text("Sair"),
          ),
        ],
      ),
    );
  }

  void _onSettingsSelected(String value) {
    switch (value) {
      case 'perfil':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidade em desenvolvimento'),
          ),
        );
        break;
      case 'sair':
        _logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/tdl.png'),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings),
            onSelected: _onSettingsSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'perfil',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Perfil do usuário'),
                ),
              ),
              const PopupMenuItem(
                value: 'sair',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sair'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 0, 92, 250),
        unselectedItemColor: const Color.fromARGB(255, 80, 80, 80),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Tarefas'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Lembretes'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendário'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Loja'),
        ],
      ),
    );
  }
}
