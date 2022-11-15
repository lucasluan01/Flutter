import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product_data.dart';
import 'package:loja_virtual/pages/product_page.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(product: product)),
          );
        }),
        child: Row(
          children: [
            Image.network(
              product.images![0],
              fit: BoxFit.cover,
              width: 80,
            ),
            const SizedBox(width: 16),
            Wrap(
              direction: Axis.vertical,
              spacing: 16,
              children: [
                Text(product.name!),
                Text(
                  "R\$ ${product.price!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
