import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;
  const AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            child: const Text("Adicionar Lista"),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            child: const Text("Adicionar Grade"),
          ),
        ),
      ],
    );
  }
}
