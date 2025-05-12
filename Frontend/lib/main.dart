import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'routes/app_routes.dart';
import 'providers/task_provider.dart';
import 'providers/usuario_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  // Carregar idioma salvo
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language') ?? 'pt';
  final initialLocale = langCode == 'pt' ? const Locale('pt', 'BR') : Locale(langCode);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider(initialLocale)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'TDL Lembretes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
