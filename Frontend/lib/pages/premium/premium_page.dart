import 'package:flutter/material.dart';
import 'widgets/premium_intro_card.dart';
import 'widgets/premium_features.dart';
import 'widgets/premium_disclaimer.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0A4D9E);
    const cardBlue = Color(0xFF063568);
    const accentBlue = Color(0xFF4AB3FF);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = primaryBlue.withValues(alpha: isDark ? 0.30 : 0.18);
    final headerTextColor = isDark ? Colors.white : primaryBlue;
    final backIconColor = isDark ? Colors.white : primaryBlue;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: backIconColor,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 4),
              _PremiumHeader(textColor: headerTextColor, iconColor: primaryBlue),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PremiumIntroCard(
                        backgroundColor: cardBlue,
                      ),
                      const SizedBox(height: 20),
                      PremiumFeatures(
                        iconColor: accentBlue,
                      ),
                      const SizedBox(height: 20),
                      _PremiumPlanCard(
                        backgroundColor: cardBlue,
                        accentColor: accentBlue,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Funcionalidade de pagamento em desenvolvimento.',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Ativar plano premium',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(223, 255, 255, 255),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const PremiumDisclaimer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumHeader extends StatelessWidget {
  final Color textColor;
  final Color iconColor;

  const _PremiumHeader({
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.workspace_premium,
            size: 38,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'PLANO PREMIUM',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Desbloqueie a melhor experiência do TDLembretes',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.75),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _PremiumPlanCard extends StatelessWidget {
  final Color backgroundColor;
  final Color accentColor;

  const _PremiumPlanCard({
    required this.backgroundColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.7),
          width: 1.8,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium mensal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'R\$ 14,99 / mês',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Renovação automática. Cancele quando quiser.',
                  style: TextStyle(
                    color: Color.fromARGB(228, 255, 255, 255),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
