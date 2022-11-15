import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: const Text(
          "Cupom de desconto",
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Digite o código do cupom",
                border: OutlineInputBorder(),
              ),
              initialValue: CartModel.of(context).couponCode,
              onFieldSubmitted: ((value) {
                FirebaseFirestore.instance.collection("coupons").doc(value.trim()).get().then((doc) {
                  if (doc.data() != null) {
                    CartModel.of(context).setCoupon(value, doc.data()!["percent"]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Desconto de ${doc.data()!['percent']}% aplicado."),
                        backgroundColor: Colors.green,
                      ),
                    );
                    return;
                  }
                  CartModel.of(context).setCoupon(null, 0);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Cupom não encontrado."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
