import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/common/custom_icon_buttom.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SectionHeader extends StatelessWidget {
  SectionHeader(this.section);
  Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    if (homeManager.editing) {
      return Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: InputDecoration(
                  hintText: "Título", isDense: true, border: InputBorder.none),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
              onChanged: (text) => section.name = text,
            ),
          ),
          CustomIconButtom(
            iconData: Icons.delete,
            color: Colors.white,
            onTap: () {
              homeManager.removeSection(section);
            },
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? "",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }
}
