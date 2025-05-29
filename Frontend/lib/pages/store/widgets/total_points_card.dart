import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalPointsCard extends StatelessWidget {
  final int total;

  const TotalPointsCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 93, 104, 168),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.token, size: 32, color: Colors.white),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seus pontos',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '$total Tokens',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
