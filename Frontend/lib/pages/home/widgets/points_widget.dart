import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? const Color.fromARGB(255, 224, 204, 128) : Colors.amber.shade100;
    final textColor = isDark ? Colors.black : Colors.black87;

    if (usuario == null) {
      return Text(
        "Carregando pontos...",
        style: TextStyle(color: textColor),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.stars, size: 40, color: textColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Você tem ${usuario.pontos} pontos!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
