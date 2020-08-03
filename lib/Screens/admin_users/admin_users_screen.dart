import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/custom_drawer/custom_drawer.dart';
import 'package:saudavel_life_v2/models/admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(adminUsersManager.users[index].email,
                        style: TextStyle(color: Colors.white)),
                  );
                },
                highlightTextStyle:
                    TextStyle(color: Colors.white, fontSize: 20),
                showPreview: true,
                strList: adminUsersManager.names,
                indexedHeight: (index) => 80);
          },
        ));
  }
}
