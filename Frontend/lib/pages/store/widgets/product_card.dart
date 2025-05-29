import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String produtoId;
  final String nome;
  final String preco;
  final String imagem;
  final String descricao;
  final int quantidade;
  final void Function(String produtoId) onConfirm;

  const ProductCard({
    super.key,
    required this.produtoId,
    required this.nome,
    required this.preco,
    required this.imagem,
    required this.descricao,
    required this.quantidade,
    required this.onConfirm,
  });

  void _mostrarDetalhes(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(nome),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descrição: $descricao'),
            const SizedBox(height: 8),
            Text('Quantidade disponível: $quantidade'),
            const SizedBox(height: 8),
            Text('Preço: $preco'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm(produtoId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Comprar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagemValida = imagem.endsWith('.jpg') || imagem.endsWith('.png');

    return GestureDetector(
      onTap: () => _mostrarDetalhes(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagemValida ? imagem : 'assets/giftcard.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nome,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    preco,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
