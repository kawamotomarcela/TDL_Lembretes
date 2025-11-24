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

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _theme = await _preferenceService.getThemeMode() ?? 'system';
    _language = await _preferenceService.getLanguage() ?? 'pt';
    setState(() {});
  }

  void _savePreferences() {
    _preferenceService.setThemeMode(_theme);
    _preferenceService.setLanguage(_language);

    Provider.of<ThemeProvider>(context, listen: false).setTheme(_theme);
    Provider.of<LocaleProvider>(context, listen: false).setLocale(_language);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).preferencesSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local.settings,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: ListView(
            children: [
              Text(
                local.settings,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                local.preferencesSaved, 
                style: TextStyle(
                  fontSize: 13,
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                local.theme,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _theme,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _theme = value);
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'light',
                          child: Text(local.light),
                        ),
                        DropdownMenuItem(
                          value: 'dark',
                          child: Text(local.dark),
                        ),
                        DropdownMenuItem(
                          value: 'system',
                          child: Text(local.system),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                local.language,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _language,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _language = value);
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'pt',
                          child: Text(local.portuguese),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(local.english),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _savePreferences,
                  style: FilledButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Text(
                    local.save,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

