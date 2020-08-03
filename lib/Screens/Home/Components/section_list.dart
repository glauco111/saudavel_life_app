import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/item_tile2.dart';
import 'package:saudavel_life_v2/Screens/Home/Components/section_header.dart';
import 'package:saudavel_life_v2/models/section.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: section.items.length,
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemBuilder: (_, index) {
                return ItemTile2(section.items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
