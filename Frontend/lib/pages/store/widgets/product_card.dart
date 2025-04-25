import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String nome;
  final String preco;
  final String imagem;
  final VoidCallback onConfirm;

  const ProductCard({
    super.key,
    required this.nome,
    required this.preco,
    required this.imagem,
    required this.onConfirm,
  });

  void _confirmarCompra(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar Compra'),
        content: Text('Deseja realmente comprar o produto "$nome"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Confirmar');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compra confirmada!')),
              );
              onConfirm();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagem,
                fit: BoxFit.cover,
                width: double.infinity,
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
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmarCompra(context),
                    icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                    label: const Text("Comprar", style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
