import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    if (user.containsKey("money")) {
      return ListTile(
        title: Text(user["name"]),
        subtitle: Text(user["email"]),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Pedidos: ${user['orders']}"),
            Text("Gasto: R\$ ${user['money'].toStringAsFixed(2)}"),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 75.0,
            child: Shimmer.fromColors(
              baseColor: Colors.black.withOpacity(0.5),
              highlightColor: Colors.black.withOpacity(0.1),
              child: Container(
                height: 50,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
