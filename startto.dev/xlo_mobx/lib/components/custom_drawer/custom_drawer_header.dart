import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/login_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userManagerStore = GetIt.instance<UserManagerStore>();

    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Observer(
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    if (userManagerStore.isLoggedIn) {
                      GetIt.I<PageStore>().setPage(4);
                      return;
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (userManagerStore.isLoggedIn) ...[
                        Text(
                          userManagerStore.user!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          userManagerStore.user!.email,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                      if (!userManagerStore.isLoggedIn)
                        const Text(
                          "Entre ou cadastre-se",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
