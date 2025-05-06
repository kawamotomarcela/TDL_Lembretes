import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/pages/store/widgets/product_card.dart';
import 'package:grupotdl/pages/store/widgets/info_store.dart';
import 'package:grupotdl/pages/store/widgets/total_points_card.dart';
import 'package:grupotdl/providers/usuario_provider.dart';

class LojaPage extends StatelessWidget {
  LojaPage({super.key});

  final List<Map<String, String>> produtos = [
    {
      'nome': 'Gift Card',
      'preco': 'R\$ 500 Tokens',
      'imagem': 'assets/giftcard.jpg',
    },
    {
      'nome': 'Pacote de Moedas',
      'preco': 'R\$ 200 Tokens',
      'imagem': 'assets/giftcard.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 3;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const InfoCard(),
              const SizedBox(height: 12),

              TotalPointsCard(total: usuario?.pontos ?? 0),

              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: produtos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return ProductCard(
                    nome: produto['nome']!,
                    preco: produto['preco']!,
                    imagem: produto['imagem']!,
                    onConfirm: () {
                      debugPrint('Produto comprado: ${produto['nome']}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
