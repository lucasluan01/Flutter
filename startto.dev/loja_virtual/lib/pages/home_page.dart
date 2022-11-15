import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/order_page.dart';
import 'package:loja_virtual/tabs/categories_tab.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/orders_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/drawer_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return PageView(
      controller: pageController,
      children: [
        Scaffold(
          drawer: DrawerCustom(pageController: pageController),
          body: const HomeTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Categorias"),
            centerTitle: true,
          ),
          drawer: DrawerCustom(pageController: pageController),
          body: const CategoriesTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          drawer: DrawerCustom(pageController: pageController),
          appBar: AppBar(
            title: const Text("Meus pedidos"),
            centerTitle: true,
          ),
          body: const OrdersTab(),
        ),
      ],
    );
  }
}
