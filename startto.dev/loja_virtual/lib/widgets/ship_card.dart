import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: const Text(
          "Calcular frete",
        ),
        leading: const Icon(Icons.location_on_outlined),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Digite o CEP",
                border: OutlineInputBorder(),
              ),
              initialValue: "",
              onFieldSubmitted: ((value) {}),
            ),
          ),
        ],
      ),
    );
  }
}
