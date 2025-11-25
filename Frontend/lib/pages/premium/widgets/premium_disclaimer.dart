import 'package:flutter/material.dart';

class PremiumDisclaimer extends StatelessWidget {
  const PremiumDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'O valor pode variar conforme taxas da plataforma de pagamento.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(157, 255, 255, 255),
        fontSize: 11,
      ),
    );
  }
}
