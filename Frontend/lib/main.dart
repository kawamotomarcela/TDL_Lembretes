import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

import 'api/api_client.dart';
import 'generated/l10n.dart';
import 'routes/app_routes.dart';

// Providers
import 'providers/task_provider.dart';
import 'providers/task_ofc_provider.dart';
import 'providers/usuario_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/produto_provider.dart';

// Services
import 'services/task_service.dart';
import 'services/task_ofc_service.dart';
import 'services/usuario_service.dart';
import 'services/produto_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Locale
  await initializeDateFormatting('pt_BR', null);
  _setupLogging();

  // HTTP Client
  final apiClient = ApiClient();
  await apiClient.init();

  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language') ?? 'pt';
  final initialLocale =
      langCode == 'pt' ? const Locale('pt', 'BR') : Locale(langCode);

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),

        // Tema
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Locale
        ChangeNotifierProvider(create: (_) => LocaleProvider(initialLocale)),

        // Tarefas Personalizadas
        ChangeNotifierProvider(
          create: (_) => TaskProvider(taskService: TaskService(apiClient)),
        ),

        // Tarefas Oficiais
        ChangeNotifierProvider(
          create: (_) => TaskOfcProvider(TaskOfcService(apiClient)),
        ),

        // Produto
        ChangeNotifierProvider(
          create: (_) => ProdutoProvider(ProdutoService(apiClient)),
        ),

        // Usuário
        ProxyProvider<ApiClient, UsuarioService>(
          update: (_, api, __) => UsuarioService(api),
        ),
        ChangeNotifierProxyProvider<UsuarioService, UsuarioProvider>(
          create: (_) => UsuarioProvider(),
          update: (_, usuarioService, usuarioProvider) =>
              usuarioProvider!..setService(usuarioService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('[${record.level.name}] ${record.loggerName}: ${record.message}');
  });
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
