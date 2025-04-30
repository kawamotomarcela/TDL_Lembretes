import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    if (usuario == null) {
      return const Text("Carregando pontos...");
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Você tem ${usuario.pontos} pontos!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
