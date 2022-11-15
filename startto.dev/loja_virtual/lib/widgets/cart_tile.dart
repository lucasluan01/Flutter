import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/cart_data.dart';
import 'package:loja_virtual/data/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.cartData});

  final CartData cartData;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: widget.cartData.productData == null
          ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(widget.cartData.category)
                  .collection("items")
                  .doc(widget.cartData.productId)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 70,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                widget.cartData.productData = ProductData.fromDocument(snapshot.data!);
                return _buildContent(context);
              },
            )
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    CartModel.of(context).updatePrices();
    return Row(
      children: [
        Image.network(
          widget.cartData.productData!.images![0],
          height: 175,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.cartData.productData!.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tamanho: ${widget.cartData.size}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "R\$ ${widget.cartData.productData!.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: widget.cartData.quantity == 1
                          ? null
                          : () {
                              CartModel.of(context).decProduct(widget.cartData);
                            },
                      child: const Icon(Icons.remove),
                    ),
                    Text(widget.cartData.quantity.toString()),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          CartModel.of(context).incProduct(widget.cartData);
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          CartModel.of(context).removeCartItem(widget.cartData);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
