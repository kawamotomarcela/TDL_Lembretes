import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/generated/l10n.dart';
import '../../../providers/usuario_provider.dart';
import '../../../providers/cupom_provider.dart';
import '../../../models/cupom_model.dart';

class CuponsPage extends StatelessWidget {
  const CuponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final usuario = context.watch<UsuarioProvider>().usuario;
    final cupomProvider = context.watch<CupomProvider>();

    final cupons = cupomProvider.cupons;
    final carregando = cupomProvider.carregando;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.couponsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : cupons.isEmpty
                ? Center(
                    child: Text(
                      local.noCouponsAvailable,
                      style: const TextStyle(fontSize: 16),
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
                            vertical: 10,
                          ),
                          leading: const Icon(Icons.card_giftcard, color: Colors.indigo),
                          title: Text(
                            cupom.titulo,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cupom.descricao),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cupom.codigo,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
