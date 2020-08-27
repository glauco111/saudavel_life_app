import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/custom_drawer/custom_drawer_header.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Drawer(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, Colors.green],
                begin: Alignment.topCenter),
          ),
        ),
        const Divider(),
        ListView(
          children: <Widget>[
            CustomDrawerHeader(),
            DrawerTile(
              iconData: Icons.home,
              title: 'Início',
              page: 0,
            ),
            DrawerTile(
              iconData: Icons.list,
              title: 'Produtos',
              page: 1,
            ),
            DrawerTile(
              iconData: Icons.playlist_add_check,
              title: 'Meus Pedidos',
              page: 2,
            ),
            DrawerTile(
              iconData: Icons.person_pin,
              title: 'Perfil',
              page: 3,
            ),
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return Column(
                    children: <Widget>[
                      const Divider(),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Usuários',
                        page: 4,
                      ),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Pedidos',
                        page: 5,
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ]),
    );
  }
}
