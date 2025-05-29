import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cupom_model.dart';
import '../../../providers/cupom_provider.dart';
import '../../../providers/usuario_provider.dart';

class CuponsPage extends StatefulWidget {
  const CuponsPage({super.key});

  @override
  State<CuponsPage> createState() => _CuponsPageState();
}

class _CuponsPageState extends State<CuponsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final usuario = context.read<UsuarioProvider>().usuario;
      if (usuario != null) {
        context.read<CupomProvider>().carregarCuponsDoUsuario(usuario.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    final cupomProvider = context.watch<CupomProvider>();
    final cupons = cupomProvider.cupons;
    final carregando = cupomProvider.carregando;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Cupons"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : cupons.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum cupom disponível.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    itemCount: cupons.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final CupomModel cupom = cupons[index];

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: const Icon(Icons.card_giftcard, color: Colors.indigo),
                          title: Text(
                            cupom.nome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cupom.descricao),
                          trailing: Text(
                            "${cupom.custoEmPontos} pts",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
