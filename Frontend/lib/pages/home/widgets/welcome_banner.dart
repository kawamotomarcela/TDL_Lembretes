import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? const Color.fromARGB(255, 114, 89, 173) : Colors.deepPurple.shade50;
    final textColor = isDark ? Colors.white : Colors.deepPurple.shade900;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Bem-vindo de volta ao TDLembretes =)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            'assets/testAgenda.png',
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
