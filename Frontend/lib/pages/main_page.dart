import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/generated/l10n.dart';

import '../routes/app_routes.dart';

import 'calendar/calendar_page.dart';
import 'tasks/task_list_page.dart';
import 'store/store_page.dart';
import 'profile/profile_page.dart';
import 'about/about_page.dart';
import 'premium/premium_page.dart';
import 'settings/settings_page.dart';
import 'coupons/coupons_page.dart';
import 'home/home_page.dart';

import '../providers/theme_provider.dart';
import '../providers/usuario_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomePage(),
      TaskListPage(),
      CalendarPage(),
      LojaPage(),
      CuponsPage(),
    ];
  }

  Future<void> _logout() async {
    final local = S.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(local.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(local.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final themeProvider = context.read<ThemeProvider>();
              final usuarioProvider = context.read<UsuarioProvider>();

              await themeProvider.resetThemeToDefault();
              if (!mounted) return;

              await usuarioProvider.logout();
              if (!mounted) return;

              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: Text(local.exit),
          ),
        ],
      ),
    );
  }

  void _onSettingsSelected(String value) {
    switch (value) {
      case 'meu_perfil':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
      case 'premium':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumPage()),
        );
        break;
      case 'config':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
        break;
      case 'sobre':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AboutPage()),
        );
        break;
      case 'sair':
        _logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    final titles = [
      local.homePageTitle,
      local.tasksPageTitle,
      local.calendarPageTitle,
      local.storePageTitle,
      local.couponsPageTitle,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/tdl.png'),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings),
            onSelected: _onSettingsSelected,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'meu_perfil',
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(local.profile),
                ),
              ),
              PopupMenuItem(
                value: 'premium',
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(local.premium),
                ),
              ),
              PopupMenuItem(
                value: 'config',
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(local.settings),
                ),
              ),
              PopupMenuItem(
                value: 'sobre',
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(local.about),
                ),
              ),
              PopupMenuItem(
                value: 'sair',
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(local.logout),
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
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_circle_outline),
            label: local.tasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: local.calendar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.storefront_outlined),
            label: local.store,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.card_giftcard),
            label: local.coupons,
          ),
        ],
      ),
    );
  }
}
