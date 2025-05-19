import 'package:flutter/material.dart';
import 'package:grupotdl/generated/l10n.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    final List<Map<String, String>> coupons = [
      {
        'title': 'Desconto de 10%',
        'description': 'Válido em qualquer produto da loja.',
        'code': 'TDL10',
      },
      {
        'title': 'Frete Grátis',
        'description': 'Frete grátis para compras acima de R\$100.',
        'code': 'FRETEGRATIS',
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: coupons.isEmpty
            ? Center(
                child: Text(
                  local.noCouponsAvailable, 
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        coupon['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(coupon['description'] ?? ''),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.card_giftcard, color: Colors.indigo),
                          Text(
                            coupon['code'] ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
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
