import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/section.dart';

// ignore: must_be_immutable
class SectionHeader extends StatelessWidget {
  SectionHeader(this.section);
  Section section;

  @override
  Widget build(BuildContext context) {
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
