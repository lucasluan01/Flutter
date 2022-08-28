import 'package:flutter/material.dart';
import 'package:responsividade_flutter/pages/home/widgets/app_bar/mobile_app_bar.dart';
import 'package:responsividade_flutter/pages/home/widgets/app_bar/web_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: constraints.maxWidth < 800
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(56),
                  child: MobileAppBar(),
                )
              : const PreferredSize(
                  preferredSize: Size.fromHeight(72),
                  child: WebAppBar(),
                ),
          drawer: Drawer(),
          body: Center(
            child: Text(
              'biggest ${constraints.biggest} \t smallest ${constraints.smallest}',
            ),
          ),
        );
      },
    );
  }
}
