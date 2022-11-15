import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/cart_page.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
      },
      child: const Icon(Icons.shopping_cart),
    );
  }
}
