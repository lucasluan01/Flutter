import 'package:flutter/material.dart';
import 'package:responsividade_flutter/pages/home/widgets/app_bar/mobile_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // print('biggest ${constraints.biggest} \t smallest ${constraints.smallest}');
        return Scaffold(
          appBar: constraints.maxWidth < 800 ? const MobileAppBar() : AppBar(),
          drawer: Drawer(),
        );
      },
    );
  }
}
