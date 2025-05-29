import 'package:flutter/material.dart';
import 'package:grupotdl/generated/l10n.dart';

import 'calendar/calendar_page.dart';
import 'tasks/task_list_page.dart';
import 'store/store_page.dart';
import 'profile/profile_page.dart';
import 'about/about_page.dart';
import 'settings/settings_page.dart';
import 'coupons/coupons_page.dart'; 
import '../routes/app_routes.dart';
import 'home/home_page.dart';

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
    _pages = [
      const HomePage(),
      const TaskListPage(),
      const CalendarPage(),
      LojaPage(),         
      const CuponsPage(),  
    ];
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(S.of(context).logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: Text(S.of(context).exit),
          ),
        ],
      ),
    );
  }

  void _onSettingsSelected(String value) {
    if (value == 'meu_perfil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
    } else if (value == 'config') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      );
    } else if (value == 'sobre') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutPage()),
      );
    } else if (value == 'sair') {
      _logout();
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
        backgroundColor: Colors.blueAccent,
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
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: local.home),
          BottomNavigationBarItem(icon: const Icon(Icons.check_circle_outline), label: local.tasks),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: local.calendar),
          BottomNavigationBarItem(icon: const Icon(Icons.storefront_outlined), label: local.store),
          BottomNavigationBarItem(icon: const Icon(Icons.card_giftcard), label: local.coupons),
        ],
      ),
    );
  }
}

