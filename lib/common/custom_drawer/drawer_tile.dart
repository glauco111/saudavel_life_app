import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saudavel_life_v2/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor : Colors.white,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: curPage == page ? primaryColor : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
