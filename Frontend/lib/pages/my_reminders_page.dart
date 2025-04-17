import 'package:flutter/material.dart';

class SeusLembretesPage extends StatefulWidget {
  const SeusLembretesPage({super.key});

  @override
  State<SeusLembretesPage> createState() => _SeusLembretesPageState();
}

class _SeusLembretesPageState extends State<SeusLembretesPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _lembretes = [
    {
      'nome': 'Pagar boletos',
      'observacoes': 'Luz, água e internet',
    },
    {
      'nome': 'Reunião com João',
      'observacoes': 'Apresentar o relatório mensal',
    },
    {
      'nome': 'Comprar presente',
      'observacoes': 'Aniversário da Maria na sexta',
    },
  ];

  String _filtro = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _filtro = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lembretesFiltrados = _lembretes.where((lembrete) {
      return lembrete['nome']!.toLowerCase().contains(_filtro) ||
          lembrete['observacoes']!.toLowerCase().contains(_filtro);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Seus Lembretes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar lembretes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: lembretesFiltrados.isEmpty
                ? const Center(child: Text("Nenhum lembrete encontrado"))
                : ListView.separated(
                    itemCount: lembretesFiltrados.length,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (context, index) {
                      final item = lembretesFiltrados[index];
                      return ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(item['nome']!),
                        subtitle: Text(item['observacoes']!),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

