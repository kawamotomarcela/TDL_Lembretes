import 'dart:io';
import 'package:flutter/material.dart';
import '../../../services/preference_service.dart';
import '../../../utils/show_snackbar.dart';

class IpConfigDialog extends StatefulWidget {
  const IpConfigDialog({super.key});

  @override
  State<IpConfigDialog> createState() => _IpConfigDialogState();
}

class _IpConfigDialogState extends State<IpConfigDialog> {
  final _ipController = TextEditingController();
  final _preferenceService = PreferenceService();
  bool _isTestingConnection = false;

  @override
  void initState() {
    super.initState();
    _loadIp();
  }

  Future<void> _loadIp() async {
    final ip = await _preferenceService.getIpAddress() ?? '000.000.000';
    _ipController.text = ip;
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  Future<void> _saveIp() async {
    final ip = _ipController.text.trim();

    if (ip.isEmpty) {
      showSnackBar(context, "Digite um IP válido!", color: Colors.red);
      return;
    }

    setState(() => _isTestingConnection = true);

    try {
      final socket = await Socket.connect(
        ip,
        7008,
        timeout: const Duration(seconds: 3),
      );
      socket.destroy();

      await _preferenceService.setIpAddress(ip);

      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, "IP salvo com sucesso!", color: Colors.green);
    } on SocketException {
      if (mounted) {
        showSnackBar(
          context,
          "Não foi possível conectar ao servidor no IP informado.",
          color: Colors.red,
        );
      }
    } finally {
      if (mounted) setState(() => _isTestingConnection = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final textColor = theme.colorScheme.onSurface;
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF020617) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.settings_ethernet_rounded,
              color: primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Configurar IP do servidor",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 19,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informe o IP do servidor para o TDLembretes se conectar:",
            style: TextStyle(
              fontSize: 15,
              color: textColor.withValues(alpha: 0.85),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ipController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              labelText: "Endereço IP",
              labelStyle: TextStyle(
                fontSize: 14,
                color: textColor.withValues(alpha: 0.9),
              ),
              hintText: "Ex: 192.168.0.10",
              hintStyle: TextStyle(
                fontSize: 14,
                color: textColor.withValues(alpha: 0.6),
              ),
              prefixIcon: const Icon(Icons.dns_rounded, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: primary,
                  width: 1.8,
                ),
              ),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Certifique-se que o servidor está ligado na mesma rede.",
            style: TextStyle(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isTestingConnection ? null : () => Navigator.pop(context),
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: textColor.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        FilledButton(
          onPressed: _isTestingConnection ? null : _saveIp,
          style: FilledButton.styleFrom(
            backgroundColor: primary,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: _isTestingConnection
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  "Salvar",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
        ),
      ],
    );
  }
}




