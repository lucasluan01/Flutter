import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer_header.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer_tile.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final pageStore = GetIt.instance<PageStore>();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            const CustomDrawerHeader(),
            CustomDrawerTile(
              icon: Icons.campaign,
              isActive: pageStore.pageIndex == 0,
              title: "Anúncios",
              onTap: () {
                pageStore.setPage(0);
              },
            ),
            CustomDrawerTile(
              icon: Icons.add,
              isActive: pageStore.pageIndex == 1,
              title: "Adicionar anúncio",
              onTap: () {
                pageStore.setPage(1);
              },
            ),
            CustomDrawerTile(
              icon: Icons.chat,
              isActive: pageStore.pageIndex == 2,
              title: "Chat",
              onTap: () {
                pageStore.setPage(2);
              },
            ),
            CustomDrawerTile(
              icon: Icons.favorite,
              isActive: pageStore.pageIndex == 3,
              title: "Favoritos",
              onTap: () {
                pageStore.setPage(3);
              },
            ),
            CustomDrawerTile(
              icon: Icons.person,
              isActive: pageStore.pageIndex == 4,
              title: "Minha conta",
              onTap: () {
                pageStore.setPage(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
