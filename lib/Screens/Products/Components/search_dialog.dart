import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String initialText;
  const SearchDialog(this.initialText);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 5,
          right: 5,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.grey[600],
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
