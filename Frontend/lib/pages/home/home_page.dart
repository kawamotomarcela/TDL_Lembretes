import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/usuario_provider.dart';
import '../../providers/task_provider.dart' as tp;

import 'widgets/home_header.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/task_overview_widget.dart';
import 'widgets/points_widget.dart';
import 'widgets/news_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<tp.TaskProvider>(
          builder: (context, taskProvider, _) {
            final tarefas = taskProvider.tarefas;

            final pendentes = tarefas.where((t) => t.status.name == 'pendente').length;
            final emAndamento = tarefas.where((t) => t.status.name == 'emAndamento').length;
            final concluidas = tarefas.where((t) => t.status.name == 'concluida').length;
            final expiradas = tarefas.where((t) => t.status.name == 'expirada').length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(userName: usuario?.nome ?? 'Usuário'),
                const SizedBox(height: 20),
                const WelcomeBanner(),
                const SizedBox(height: 20),
                TaskOverviewWidget(
                  pendentes: pendentes,
                  emAndamento: emAndamento,
                  concluidas: concluidas,
                  expiradas: expiradas,
                ),
                const SizedBox(height: 20),
                const PointsWidget(),
                const SizedBox(height: 20),
                const NewsSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}
