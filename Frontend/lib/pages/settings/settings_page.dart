import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/generated/l10n.dart';

import '../../services/preference_service.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _preferenceService = PreferenceService();

  String _theme = 'system';
  String _language = 'pt';
  String _ipAddress = '000.000.000'; //COLOCA IP AQUI

  final _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _theme = await _preferenceService.getThemeMode() ?? 'system';
    _language = await _preferenceService.getLanguage() ?? 'pt';
    _ipAddress = await _preferenceService.getIpAddress() ?? '000.000.000'; //COLOCA IP AQUI

    _ipController.text = _ipAddress;
    setState(() {});
  }

  void _savePreferences() {
    _preferenceService.setThemeMode(_theme);
    _preferenceService.setLanguage(_language);
    _preferenceService.setIpAddress(_ipController.text);

    Provider.of<ThemeProvider>(context, listen: false).setTheme(_theme);
    Provider.of<LocaleProvider>(context, listen: false).setLocale(_language);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).preferencesSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(local.theme, style: const TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _theme,
              onChanged: (value) {
                setState(() => _theme = value!);
              },
              items: [
                DropdownMenuItem(value: 'light', child: Text(local.light)),
                DropdownMenuItem(value: 'dark', child: Text(local.dark)),
                DropdownMenuItem(value: 'system', child: Text(local.system)),
              ],
            ),
            const SizedBox(height: 16),
            Text(local.language, style: const TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _language,
              onChanged: (value) {
                setState(() => _language = value!);
              },
              items: [
                DropdownMenuItem(value: 'pt', child: Text(local.portuguese)),
                DropdownMenuItem(value: 'en', child: Text(local.english)),
              ],
            ),
            const SizedBox(height: 16),
            Text(local.ipAddress, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _ipController,
              decoration: InputDecoration(hintText: local.exampleIp),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePreferences,
              child: Text(local.save),
            ),
          ],
        ),
      ),
    );
  }
}
