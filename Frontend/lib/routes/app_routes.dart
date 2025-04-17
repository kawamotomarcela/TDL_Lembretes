import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/calendar_page.dart';
import '../pages/reminders_page.dart';
import '../pages/task_list_page.dart';
import '../pages/store_page.dart';
import '../pages/my_reminders_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String reminders = '/reminders';
  static const String tasks = '/tasks';
  static const String store = '/store';
  static const String myReminders = '/my-reminders';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const MyHomePage(),
    calendar: (context) => const CalendarPage(),
    reminders: (context) => const PaginaLembrete(),
    tasks: (context) => const TaskListPage(),
    store: (context) => LojaPage(), 
    myReminders: (context) => const SeusLembretesPage(),
  };
}
