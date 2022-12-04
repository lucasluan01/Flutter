import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/create_ad/create_ad_screen.dart';
import 'package:xlo_mobx/screens/home_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final pageController = PageController();
  final pageStore = GetIt.instance<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction(
      (_) => pageStore.pageIndex,
      (page) => pageController.jumpToPage(page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeScreen(),
          const CreateAdScreen(),
          Container(
            color: Colors.amber,
            child: Center(
              child: ElevatedButton(
                onPressed: () => pageController.jumpToPage(4),
                child: const Text("ir para pagina verde"),
              ),
            ),
          ),
          Container(color: Colors.green),
          Container(color: Colors.purple),
        ],
      ),
    );
  }
}
