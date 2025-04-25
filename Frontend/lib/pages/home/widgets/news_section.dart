import 'package:flutter/material.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "News",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3, 
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final data = _news[index];
              return SizedBox(
                width: 200,
                child: NewsCard(
                  title: data['title']!,
                  tag: data['tag']!,
                  icon: data['icon']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

final List<Map<String, dynamic>> _news = [
  {
    'title': 'Alguma coisa aqui',
    'tag': 'Weather',
    'icon': Icons.wb_sunny_outlined,
  },
  {
    'title': 'Outra coisa legal',
    'tag': 'Update',
    'icon': Icons.health_and_safety_outlined,
  },
    {
    'title': 'Eu amo pao de batata',
    'tag': 'top',
    'icon': Icons.wb_sunny_outlined,
  },
];

class NewsCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData icon;

  const NewsCard({
    super.key,
    required this.title,
    required this.tag,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(tag),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            Icon(icon, size: 24),
          ],
        ),
      ),
    );
  }
}
