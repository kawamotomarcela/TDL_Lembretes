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
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              nome,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descrição:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(descricao, style: GoogleFonts.poppins(fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Quantidade disponível: ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$quantidade',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Preço: ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      preco,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cancelar',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
              if (quantidade > 0)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm(produtoId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Comprar',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Produto esgotado',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagemValida = imagem.endsWith('.jpg') || imagem.endsWith('.png');

    return GestureDetector(
      onTap:
          quantidade > 0
              ? () => _mostrarDetalhes(context)
              : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Produto esgotado.'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  imagemValida ? imagem : 'assets/giftcard.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder:
                      (_, __, ___) => const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey,
                        ),
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
                  if (quantidade <= 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Esgotado',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
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
