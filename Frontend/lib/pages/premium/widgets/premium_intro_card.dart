import 'package:flutter/material.dart';

class PremiumIntroCard extends StatelessWidget {
  final Color backgroundColor;

  const PremiumIntroCard({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Experiência sem limites',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Remova anúncios, desbloqueie recursos extras da loja e aproveite o máximo do TDLembretes.',
            style: TextStyle(
              color: Color.fromARGB(211, 255, 255, 255),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
