import 'package:flutter/material.dart';

class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: Theme.of(context).primaryColor,
      selected: isActive,
      textColor: Colors.black54,
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
