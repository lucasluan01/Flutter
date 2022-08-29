import 'package:flutter/material.dart';
import 'package:responsividade_flutter/pages/home/widgets/app_bar/web_app_bar_responsive.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 72,
      title: Row(
        children: [
          const Text(
            'Web',
          ),
          const SizedBox(
            width: 32,
          ),
          const WebAppBarResponsive(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          SizedBox(
            height: 38,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: Colors.white),
              ),
              child: const Text(
                'Fazer login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              child: const Text(
                'Cadastre-se',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
