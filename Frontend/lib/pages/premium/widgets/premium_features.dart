import 'package:flutter/material.dart';

class PremiumFeatures extends StatelessWidget {
  final Color iconColor;

  const PremiumFeatures({
    super.key,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      'Remoção completa de anúncios no app.',
      'Mais opções de itens e vantagens exclusivas na loja.',
      'Atualizações antecipadas e novidades primeiro para você.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'O que você recebe:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        for (final text in features)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: iconColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
