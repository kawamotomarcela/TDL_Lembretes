import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await initializeDateFormatting('pt_BR', null); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDL Lembretes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      locale: const Locale('pt', 'BR'), 
    );
  }
}


