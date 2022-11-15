import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product_data.dart';
import 'package:loja_virtual/pages/product_page.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product: product)),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.network(
              product.images![0],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(product.name!),
                  const SizedBox(height: 12),
                  Text(
                    "R\$ ${product.price!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
