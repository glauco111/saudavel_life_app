import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MoneyCard extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  MoneyCard(this.value1);
  bool value1 = true;

  @override
  _MoneyCardState createState() => _MoneyCardState();
}

class _MoneyCardState extends State<MoneyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () => setState(() => widget.value1 = false),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: (widget.value1 == false)
                          ? Colors.green[300]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/images/dinheiro.png'),
                ),
                Text(
                  'Dinheiro',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          const SizedBox(width: 50),
          GestureDetector(
            onTap: () => setState(() => widget.value1 = true),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: (widget.value1 == true)
                          ? Colors.green[300]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/images/pagar.png'),
                ),
                Text(
                  'Cartão',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}
