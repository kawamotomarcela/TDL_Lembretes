import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Sobre o app',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: textColor,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 46,
              backgroundColor: primary.withValues(alpha: 0.12),
              child: const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/tdl.png'),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'TDLEMBRETES',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Versão 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: textColor.withValues(alpha: 0.7),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descrição',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'O TDL Lembretes foi criado para te ajudar a organizar suas tarefas, '
                        'acompanhar prazos e manter sua rotina sob controle com simplicidade.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: primary.withValues(alpha: 0.12),
                child: Icon(
                  Icons.developer_mode_rounded,
                  color: primary,
                ),
              ),
              title: Text(
                'Desenvolvedor',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: textColor,
                ),
              ),
              subtitle: Text(
                'Equipe TDL Solutions',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: textColor.withValues(alpha: 0.8),
                ),
              ),
            ),

            const SizedBox(height: 8),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: primary.withValues(alpha: 0.12),
                child: Icon(
                  Icons.email_outlined,
                  color: primary,
                ),
              ),
              title: Text(
                'Contato',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: textColor,
                ),
              ),
              subtitle: Text(
                'contato@tdlembretesa.com',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: textColor.withValues(alpha: 0.8),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              '© 2025 TDL Solutions\nTodos os direitos reservados.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.6),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
