import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTileWidget extends StatelessWidget {
  const OrderTileWidget({
    super.key,
    required this.order,
  });

  final DocumentSnapshot order;

  @override
  Widget build(BuildContext context) {
    final states = ["", "Em preparação", "Em transporte", "Aguardando entrega", "Entregue"];

    return Card(
      color: Colors.grey.shade800,
      child: ExpansionTile(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "#${order.id} - ${states[order.get('status')]}",
          style: TextStyle(
            color: order.get('status') != 4 ? Colors.white : Colors.green,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Lucas Luan"),
                          Text("Rua dos bobos, 0"),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("Produtos: R\$ ${order.get('productsPrice').toStringAsFixed(2)}"),
                        Text("Total: R\$ ${order.get('total').toStringAsFixed(2)}"),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  children: order.get("products").map<Widget>(
                    (p) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text("${p['product']['name']} - ${p['size']}"),
                        subtitle: Text("${p['category']} / ${p['productId']}"),
                        trailing: Text(
                          "${p['quantity']}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Excluir",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Regredir",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Avançar",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
