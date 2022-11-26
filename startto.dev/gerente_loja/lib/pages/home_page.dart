import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/client_bloc.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/tabs/clients_tab.dart';
import 'package:gerente_loja/tabs/orders_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  late ClientBloc _clientBloc;
  late OrdersBloc _ordersBloc;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _clientBloc = ClientBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _clientBloc.dispose();
    _ordersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (page) {
          _pageController.animateToPage(
            page,
            duration: const Duration(microseconds: 500),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.black38,
        unselectedItemColor: Colors.white30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Clientes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Produtos",
          ),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          blocs: [
            Bloc((i) => _clientBloc),
          ],
          dependencies: const [],
          child: BlocProvider(
            blocs: [
              Bloc((i) => _ordersBloc),
            ],
            dependencies: const [],
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              children: <Widget>[const ClientsTab(), const OrdersTab(), Container(color: Colors.red)],
            ),
          ),
        ),
      ),
    );
  }
}
