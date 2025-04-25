import 'package:flutter/material.dart';

class PointsWidget extends StatelessWidget {
  final int points;

  const PointsWidget({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
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
              'Você tem $points pontos!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
