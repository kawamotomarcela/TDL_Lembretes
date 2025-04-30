import 'package:flutter/material.dart';
import 'widgets/home_header.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/task_overview_widget.dart';
import 'widgets/points_widget.dart';
import 'widgets/news_section.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(userName: userName),
          const SizedBox(height: 20),
          const WelcomeBanner(),
          const SizedBox(height: 20),
          const TaskOverviewWidget(),
          const SizedBox(height: 20),
          const PointsWidget(),
          const SizedBox(height: 20),
          const NewsSection(),
        ],
      ),
    );
  }
}
