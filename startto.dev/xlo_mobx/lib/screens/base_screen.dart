import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/home_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            Container(
              color: Colors.amber,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => pageController.jumpToPage(1),
                  child: const Text("ir para pagina verde"),
                ),
              ),
            ),
            Container(color: Colors.green),
            Container(color: Colors.red),
            Container(color: Colors.blue),
            Container(color: Colors.purple),
          ],
        ),
      ),
    );
  }
}
