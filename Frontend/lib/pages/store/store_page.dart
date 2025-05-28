import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';
import '../../../providers/produto_provider.dart';
import '../../../models/produto_model.dart';
import 'widgets/product_card.dart';
import 'widgets/total_points_card.dart';
import 'widgets/info_store.dart';

class LojaPage extends StatefulWidget {
  const LojaPage({super.key});

  @override
  State<LojaPage> createState() => _LojaPageState();
}

class _LojaPageState extends State<LojaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final produtoProvider = context.read<ProdutoProvider>();
      produtoProvider.carregarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    final produtoProvider = context.watch<ProdutoProvider>();

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

              // Produtos
              if (produtoProvider.carregando)
                const Center(child: CircularProgressIndicator())
              else if (produtoProvider.produtos.isEmpty)
                const Text(
                  'Nenhum produto disponível no momento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: produtoProvider.produtos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final ProdutoModel produto = produtoProvider.produtos[index];

                    return ProductCard(
                      nome: produto.nome,
                      preco: '${produto.custoEmPontos} Tokens',
                      imagem: produto.imagemUrl,
                      descricao: produto.descricao,
                      quantidade: produto.quantidadeDisponivel,
                      onConfirm: () async {
                        final sucesso = await context.read<UsuarioProvider>().comprarProdutoComProdutoProvider(
                          custo: produto.custoEmPontos,
                          produtoId: produto.id,
                          quantidadeAtual: produto.quantidadeDisponivel,
                          produtoProvider: context.read<ProdutoProvider>(),
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              sucesso
                                  ? 'Compra confirmada: ${produto.nome}'
                                  : 'Você não tem pontos suficientes.',
                            ),
                            backgroundColor: sucesso ? Colors.green : Colors.red,
                          ),
                        );
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
