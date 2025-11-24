import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

// API & Util
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
import 'providers/cupom_provider.dart';

import 'services/task_service.dart';
import 'services/task_ofc_service.dart';
import 'services/usuario_service.dart';
import 'services/produto_service.dart';
import 'services/cupom_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  _setupLogging();

  final apiClient = ApiClient();
  await apiClient.init();

  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language') ?? 'pt';
  final initialLocale =
      langCode == 'pt' ? const Locale('pt', 'BR') : Locale(langCode);

  runApp(
    MultiProvider(
      providers: [
        /// API Client base
        Provider<ApiClient>.value(value: apiClient),

        /// Temas e localização
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider(initialLocale)),

        /// Providers de funcionalidades
        ChangeNotifierProvider(
          create: (_) => TaskProvider(taskService: TaskService(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskOfcProvider(TaskOfcService(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => ProdutoProvider(ProdutoService(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => CupomProvider(CupomService(apiClient)),
        ),

        /// Serviços e dependências compostas
        ProxyProvider<ApiClient, UsuarioService>(
          update: (_, api, __) => UsuarioService(api),
        ),

        /// UsuarioProvider precisa do UsuarioService E do ApiClient para funcionar
        ChangeNotifierProxyProvider<UsuarioService, UsuarioProvider>(
          create: (_) => UsuarioProvider(),
          update: (context, usuarioService, usuarioProvider) {
            final apiClient = Provider.of<ApiClient>(context, listen: false);
            return usuarioProvider!..setService(usuarioService, apiClient);
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '[${record.level.name}] ${record.loggerName}: ${record.message}',
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryBlue = Color(0xFF1976D2);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      title: 'TDL Lembretes',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,

      // TEMA CLARO
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
        ),
      ),

      // TEMA ESCURO
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.dark,
        ),
      ),

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

