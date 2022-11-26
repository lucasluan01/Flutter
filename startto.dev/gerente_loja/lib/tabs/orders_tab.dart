import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/widgets/order_tile_widget.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersBloc = OrdersBloc();

    return StreamBuilder<List>(
        stream: ordersBloc.outOrders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum pedido encontrado"));
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return OrderTileWidget(order: snapshot.data![index]);
            },
          );
        });
  }
}
