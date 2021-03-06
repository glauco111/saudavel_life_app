import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/custom_drawer/custom_drawer.dart';
import 'package:saudavel_life_v2/models/admin_orders_manager.dart';
import 'package:saudavel_life_v2/models/admin_users_manager.dart';
import 'package:saudavel_life_v2/models/page_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(
          builder: (_, adminUsersManager, __) {
            return AlphabetListScrollView(
                // ignore: missing_return
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      adminUsersManager.users[index].name,
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      adminUsersManager.users[index].email,
                      style: TextStyle(color: primaryColor),
                    ),
                    onTap: () {
                      context
                          .read<AdminOrdersManager>()
                          .setUserFilter(adminUsersManager.users[index]);
                      context.read<PageManager>().setPage(5);
                    },
                  );
                },
                highlightTextStyle:
                    TextStyle(color: primaryColor, fontSize: 20),
                showPreview: true,
                strList: adminUsersManager.names,
                indexedHeight: (index) => 80);
          },
        ));
  }
}
