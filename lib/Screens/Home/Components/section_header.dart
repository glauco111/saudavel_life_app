import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/common/custom_icon_buttom.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();
    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: InputDecoration(
                      hintText: "Título",
                      isDense: true,
                      border: InputBorder.none),
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
          ),
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                section.error,
                style: TextStyle(color: Colors.red),
              ),
            )
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
