import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer_header.dart';
import 'package:xlo_mobx/components/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const CustomDrawerHeader(),
          DrawerTile(
            icon: Icons.campaign,
            isActive: true,
            title: "Anúncios",
            onTap: () {},
          ),
          DrawerTile(
            icon: Icons.add,
            title: "Adicionar anúncio",
            onTap: () {},
          ),
          DrawerTile(
            icon: Icons.chat,
            isActive: false,
            title: "Chat",
            onTap: () {},
          ),
          DrawerTile(
            icon: Icons.favorite,
            isActive: false,
            title: "Favoritos",
            onTap: () {},
          ),
          DrawerTile(
            icon: Icons.person,
            isActive: false,
            title: "Minha conta",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
