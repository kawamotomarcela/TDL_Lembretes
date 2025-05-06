import 'package:flutter/material.dart';
import '../../services/preference_service.dart';


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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferências salvas')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tema', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _theme,
              onChanged: (value) {
                setState(() => _theme = value!);
              },
              items: const [
                DropdownMenuItem(value: 'light', child: Text('Claro')),
                DropdownMenuItem(value: 'dark', child: Text('Escuro')),
                DropdownMenuItem(value: 'system', child: Text('Sistema')),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Idioma', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _language,
              onChanged: (value) {
                setState(() => _language = value!);
              },
              items: const [
                DropdownMenuItem(value: 'pt', child: Text('Português')),
                DropdownMenuItem(value: 'en', child: Text('Inglês')),
              ],
            ),
            const SizedBox(height: 16),
            const Text('IP da máquina (conexão com C#)', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(hintText: 'Ex: 192.168.0.1'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePreferences,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
