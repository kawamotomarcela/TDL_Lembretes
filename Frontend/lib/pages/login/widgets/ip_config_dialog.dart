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
      final socket = await Socket.connect(ip, 7008, timeout: const Duration(seconds: 3));
      socket.destroy(); 

      await _preferenceService.setIpAddress(ip);

      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, "IP salvo com sucesso!", color: Colors.green);
    } on SocketException {
      if (mounted) {
        showSnackBar(context, "Não foi possível conectar ao servidor no IP informado.", color: Colors.red);
      }
    } finally {
      if (mounted) setState(() => _isTestingConnection = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Configurar IP do Servidor"),
      content: TextField(
        controller: _ipController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Ex: 192.168.0.10",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _isTestingConnection ? null : _saveIp,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: _isTestingConnection
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Salvar"),
        ),
      ],
    );
  }
}


