import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("orders").doc(orderId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pedido: ${snapshot.data!.id}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Descrição:",
                ),
                const SizedBox(height: 4),
                for (var item in snapshot.data!["products"])
                  Text("${item["quantity"]} x ${item["product"]["name"]} (R\$ ${item["product"]["price"]})"),
                const SizedBox(height: 4),
                Text(
                  "Total: R\$ ${(snapshot.data!['total'] as num).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    buidCircle(title: "1", subtitle: "Separando", status: snapshot.data!["status"], thisStatus: 1),
                    const Expanded(child: Divider(thickness: 2)),
                    buidCircle(title: "2", subtitle: "Em transporte", status: snapshot.data!["status"], thisStatus: 2),
                    const Expanded(child: Divider(thickness: 2)),
                    buidCircle(title: "3", subtitle: "Entregue", status: snapshot.data!["status"], thisStatus: 3),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buidCircle({
    required String title,
    required String subtitle,
    required int status,
    required int thisStatus,
  }) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey.shade500;
      child = Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = const Icon(Icons.check);
    }

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle),
      ],
    );
  }
}
