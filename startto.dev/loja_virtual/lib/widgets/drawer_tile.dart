import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.pageController,
    required this.pageIndex,
  });

  final String text;
  final IconData icon;
  final PageController pageController;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      leading: Icon(
        icon,
        color: pageController.page!.round() == pageIndex ? Colors.black : Colors.grey,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: pageController.page!.round() == pageIndex ? Colors.black : Colors.grey,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        pageController.jumpToPage(pageIndex);
      },
    );
  }
}
