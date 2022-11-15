import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/pages/login_page.dart';
import 'package:loja_virtual/widgets/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Loja Virtual',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Olá,",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ScopedModelDescendant<UserModel>(
                    builder: (context, child, model) {
                      return GestureDetector(
                        child: Text(
                          model.isLoggedIn() ? model.userData["name"] : "Entre ou cadastre-se",
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  DrawerTile(
                    text: 'Início',
                    icon: Icons.home,
                    pageController: pageController,
                    pageIndex: 0,
                  ),
                  DrawerTile(
                    text: 'Categorias',
                    icon: Icons.category,
                    pageController: pageController,
                    pageIndex: 1,
                  ), 
                  DrawerTile(
                    text: 'Meus pedidos',
                    icon: Icons.list_alt,
                    pageController: pageController,
                    pageIndex: 3,
                  ),
                ],
              ),
            ),
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return ListTile(
                  tileColor: Colors.transparent,
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Sair",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    model.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
