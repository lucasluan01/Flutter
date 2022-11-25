import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/client_bloc.dart';
import 'package:gerente_loja/widgets/user_tile_widget.dart';

class ClientsTab extends StatelessWidget {
  const ClientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final clientBloc = ClientBloc();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Pesquisar",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        StreamBuilder<List>(
          stream: clientBloc.outClients,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Nenhum usuário encontrado"),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return UserTileWidget(
                  user: snapshot.data![index],
                );
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              itemCount: snapshot.data!.length,
            );
          },
        ),
      ],
    );
  }
}
