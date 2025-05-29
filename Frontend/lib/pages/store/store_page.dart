import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/usuario_provider.dart';
import '../../../providers/produto_provider.dart';
import '../../../providers/cupom_provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProdutoProvider>().carregarProdutos();
    });
  }

  Future<void> _handleCompra({
    required String produtoId,
    required int custo,
    required String nomeProduto,
  }) async {
    final usuarioProvider = context.read<UsuarioProvider>();
    final produtoProvider = context.read<ProdutoProvider>();

    final sucesso = await usuarioProvider.comprarProduto(
      produtoId: produtoId,
      custoTotal: custo,
      produtoProvider: produtoProvider,
    );

    if (!mounted) return;

    final usuario = usuarioProvider.usuario;
    if (sucesso && usuario != null) {
      await context.read<CupomProvider>().carregarCuponsDoUsuario(usuario.id);
      if (!mounted) return;
    }

    final mensagem = sucesso
        ? 'Compra confirmada: $nomeProduto'
        : usuarioProvider.erro ?? 'Erro ao realizar a compra.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: sucesso ? Colors.green : Colors.red,
      ),
    );
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
                    final produto = produtoProvider.produtos[index];

                    return ProductCard(
                      produtoId: produto.id,
                      nome: produto.nome,
                      preco: '${produto.custoEmPontos} Tokens',
                      imagem: produto.imagemUrl,
                      descricao: produto.descricao,
                      quantidade: produto.quantidadeDisponivel,
                      onConfirm: (produtoId) {
                        _handleCompra(
                          produtoId: produtoId,
                          custo: produto.custoEmPontos,
                          nomeProduto: produto.nome,
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
