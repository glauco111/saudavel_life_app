import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/add_tile_widget.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/section_header.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';

import 'item_tile.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);
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
            Consumer<Section>(
              builder: (_, section, __) {
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                  itemBuilder: (_, index) {
                    if (index < section.items.length)
                      // ignore: curly_braces_in_flow_control_structures
                      return ItemTile(section.items[index]);
                    else {
                      return AddTileWidget();
                    }
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
