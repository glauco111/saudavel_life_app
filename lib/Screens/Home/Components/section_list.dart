import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/item_tile2.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/section_header.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';

import 'add_tile_widget.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(),
            SizedBox(
              height: 120,
              child: Consumer<Section>(
                builder: (_, section, __) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      if (index < section.items.length) {
                        return ItemTile2(section.items[index]);
                      } else {
                        return AddTileWidget();
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 4,
                    ),
                    itemCount: homeManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
